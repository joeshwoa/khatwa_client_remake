import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:khatwa_client/Core/helper/error_toast_custom.dart';
import 'package:khatwa_client/Core/helper/toast_custom.dart';
import 'package:khatwa_client/Core/services/shared_pref_services.dart';
import 'package:khatwa_client/Core/unit/app_routes.dart';
import 'package:khatwa_client/Core/unit/constant_data.dart';
import 'package:khatwa_client/Feather/Auth/data/model/user_model.dart';
import 'package:khatwa_client/Feather/Auth/data/repository/auth_repository.dart';
import 'package:khatwa_client/old_core/helper/notifictions_helper.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static late BuildContext _context;
  static AuthCubit get(context) {
    _context = context;
    return BlocProvider.of(context);
  }

  late UserModel userModel;
  static String _unVerifiedPhone = '';
  final OtpTimerButtonController resendOTPController = OtpTimerButtonController();

  void login(String phone) async {
    try {
      emit(PhoneLoginLoading());
      final deviceToken = await FirebaseMessagingService.getDeviceToken();
      final result = await AuthRepository.login(phone: phone, deviceToken: deviceToken);
      //print(result);
      if(result['statusCode'] >= 200 && result['statusCode'] < 300) {
        emit(PhoneLoginSuccess());
        if(result['message'].toString().contains('تم ارسال رمز التحقق الى هاتفك')) {
          showToast(message: result['message']);
          _unVerifiedPhone = phone;
          _context.go(AppRouter.kOTPView);
        } else if(result['message'].toString().contains('تم تسجيل الدخول بنجاح')) {
          userModel = UserModel.fromJson(result);
          SharedPreferencesServices.setData(key: ConstantData.kUser, value: jsonEncode(userModel.toJson()));
          _context.go(AppRouter.kLayoutView);
        }
      } else {
        emit(PhoneLoginFailed());
      }
    } catch (e) {
      showErrorToast(message: e.toString());
      log(e.toString());
      emit(PhoneLoginError());
    }
  }

  void signUp(String name,String phone) async {
    try {
      emit(PhoneSignUpLoading());
      final deviceToken = await FirebaseMessagingService.getDeviceToken();
      final result = await AuthRepository.signUp(phone: phone, name: name, deviceToken: deviceToken);
      //print(result);
      if(result['statusCode'] >= 200 && result['statusCode'] < 300) {
        emit(PhoneSignUpSuccess());
        if(result['message'].toString().contains('تم ارسال رمز التحقق الى هاتفك')) {
          showToast(message: result['message']);
          _unVerifiedPhone = phone;
          _context.go(AppRouter.kOTPView);
        }
      } else {
        showErrorToast(message: result['message']);
        emit(PhoneSignUpFailed());
      }
    } catch (e) {
      showErrorToast(message: e.toString());
      log(e.toString());
      emit(PhoneSignUpError());
    }
  }

  void verifyWithOTP(String otp) async {
    try {
      emit(PhoneVerifyLoading());
      final deviceToken = await FirebaseMessagingService.getDeviceToken();
      final result = await AuthRepository.verifyWithOTP(phone: _unVerifiedPhone, otp: otp, deviceToken: deviceToken);
      //print(result);
      if(result['statusCode'] >= 200 && result['statusCode'] < 300) {
        emit(PhoneVerifySuccess());
        if(result['message'].toString().contains('تم تسجيل الدخول بنجاح')) {
          print('done');
          userModel = UserModel.fromJson(result);
          SharedPreferencesServices.setData(key: ConstantData.kUser, value: jsonEncode(userModel.toJson()));
          _context.go(AppRouter.kLayoutView);
        }
      } else {
        showErrorToast(message: result['message']);
        emit(PhoneVerifyFailed());
      }
    } catch (e) {
      showErrorToast(message: e.toString());
      log(e.toString());
      emit(PhoneVerifyError());
    }
  }

  void resendOTP() async {
    try {
      resendOTPController.loading();
      emit(ResendOTPLoading());
      final deviceToken = await FirebaseMessagingService.getDeviceToken();
      final result = await AuthRepository.login(phone: _unVerifiedPhone, deviceToken: deviceToken);
      //print(result);
      if(result['statusCode'] >= 200 && result['statusCode'] < 300) {
        showToast(message: result['message']);
        resendOTPController.startTimer();
        emit(ResendOTPSuccess());
      } else {
        showErrorToast(message: result['message']);
        emit(ResendOTPFailed());
      }
    } catch (e) {
      showErrorToast(message: e.toString());
      log(e.toString());
      emit(ResendOTPError());
    }
  }
}
