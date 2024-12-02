import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khatwa_client/Core/helper/error_toast_custom.dart';
import 'package:khatwa_client/Feather/home/data/repository/home_repository.dart';

import '../../data/model/categories_model.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  CategoriesModel categoriesModel = CategoriesModel();

  Future<void> getCategories() async {
    try {
      emit(GetCategoriesLoading());
      final result = await HomeRepository.getCategories();
      print(result);
      if(result['statusCode'] >= 200 && result['statusCode'] < 300) {
        categoriesModel = CategoriesModel.fromJson(result);
        emit(GetCategoriesSuccess());
      } else {
        emit(GetCategoriesFailed());
      }
    } catch (e) {
      showErrorToast(message: e.toString());
      log(e.toString());
      emit(GetCategoriesError());
    }
  }
}
