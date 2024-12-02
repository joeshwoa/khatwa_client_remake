import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../../../Core/services/shared_pref_services.dart';
import '../../../../Core/unit/constant_data.dart';
import '../../../../old_core/contants/api.dart';
import '../../../setting/data/model/my_trips_model.dart';
import 'activity_states.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(ActivityInitial());

  static ActivityCubit get(context) => BlocProvider.of(context);


  MyTripsModels myTripsModel=MyTripsModels();


  void getClientTrips() {



    read(
      Uri.parse(getMyTrips),
      headers: authHeadersWithToken(jsonDecode(
          SharedPreferencesServices.getData(key: ConstantData.kUser))['token']),
    ).then(
      (value) {
        print(value);
        myTripsModel=MyTripsModels.fromJson(jsonDecode(value));
      },
    ).catchError((err) {
      print(err.toString());
    });
  }




  //
  // void getClientActivityData() async {
  //   emit(GetClientProfileLoading());
  //   if (await checkInternet()) {
  //     read(
  //       Uri.parse(profileUri),
  //       headers: authHeadersWithToken(jsonDecode(
  //               SharedPreferencesServices.getData(key: ConstantData.kUser))[
  //           'token']),
  //     ).then(
  //       (value) {
  //         print(value);
  //         clientProfileModel =
  //             ClientProfileModel.fromJson(jsonDecode(value)['user']);
  //         emit(GetClientProfileSuccess());
  //       },
  //     ).catchError((err) {
  //       emit(GetClientProfileFailed());
  //       print(err.toString());
  //     });
  //   } else {
  //     emit(GetClientProfileFailed());
  //
  //     errorMessage = 'لا يوجد اتصال بالانترنت';
  //   }
  // }
}
