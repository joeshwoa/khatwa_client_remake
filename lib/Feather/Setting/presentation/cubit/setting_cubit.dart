import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khatwa_client/Core/helper/error_toast_custom.dart';
import 'package:khatwa_client/Feather/Auth/presentation/cubit/auth_cubit.dart';
import 'package:khatwa_client/Feather/Setting/data/model/ads_model.dart';
import 'package:khatwa_client/Feather/Setting/data/repository/setting_repository.dart';
import 'package:khatwa_client/Feather/Setting/presentation/cubit/setting_states.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static late BuildContext _context;
  static SettingCubit get(context) {
    _context = context;
    return BlocProvider.of(context);
  }

  late AdsModel adsModel;
  bool showAds = false;

  Future<void> getBanners () async {
    try {
      emit(GetBannersLoading());
      final result = await SettingRepository.getBanners(token: AuthCubit.get(_context).userModel.token??'');
      //print(result);
      if(result['statusCode'] >= 200 && result['statusCode'] < 300) {
        adsModel = AdsModel.fromJson(result);
        showAds = true;
        emit(GetBannersSuccess());
      } else {
        emit(GetBannersFailed());
      }
    } catch (e) {
      showErrorToast(message: e.toString());
      log(e.toString());
      emit(GetBannersError());
    }
  }
}