import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khatwa_client/Core/helper/error_toast_custom.dart';
import 'package:khatwa_client/Feather/Auth/presentation/cubit/auth_cubit.dart';
import 'package:khatwa_client/Feather/Profile/data/repository/profile_repository.dart';
import 'package:khatwa_client/Feather/Profile/presentation/cubit/profile_states.dart';
import '../../../../features/Profile/data/repository/client_profile_repo.dart';
import '../../../Auth/data/model/user_model.dart';
import '../../data/model/client_profile_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static late BuildContext _context;
  static ProfileCubit get(context) {
    _context = context;
    return BlocProvider.of(context);
  }

  File? profileImage;
  late UserModel userModel;

  ClientProfileRepo clientProfileRepo = ClientProfileRepo();

  String errorMessage = '';
  ClientProfileModel? clientProfileModel;

  Future<void> getClientProfileData() async {
    try {
      emit(GetClientProfileLoading());
      final result = await ProfileRepository.getClientProfile(token: AuthCubit.get(_context).userModel.token??'');
      print(result);
      if(result['statusCode'] >= 200 && result['statusCode'] < 300) {
        clientProfileModel = ClientProfileModel.fromJson(result['user']);
        emit(GetClientProfileSuccess());
      } else {
        emit(GetClientProfileFailed());
      }
    } catch (e) {
      showErrorToast(message: e.toString());
      log(e.toString());
      emit(GetClientProfileError());
    }
  }

  Future<void> updateProfile({String? name, String? phone,}) async {
    try {
      emit(GetClientProfileLoading());
      final result = await ProfileRepository.updateClientProfile(token: AuthCubit.get(_context).userModel.token??'', name: name, phone: phone);
      print(result);
      if(result['statusCode'] >= 200 && result['statusCode'] < 300) {
        //clientProfileModel = ClientProfileModel.fromJson(result);
        emit(GetClientProfileSuccess());
      } else {
        emit(GetClientProfileFailed());
      }
    } catch (e) {
      showErrorToast(message: e.toString());
      log(e.toString());
      emit(GetClientProfileError());
    }
  }

  void updateAvatar() async {
    try {
      emit(UpdateProfileAvatarLoading());
      profileImage = await pickImage();
      if (profileImage != null) {
        var result = await ProfileRepository.updateClientProfileAvatar(token: AuthCubit.get(_context).userModel.token??'', image: profileImage!);
        print(result);
        if (result.statusCode == 200 || result.statusCode == 201) {
          emit(UpdateProfileAvatarSuccess());
        }
        else{
          emit(UpdateProfileAvatarFailed());
        }
      }
    } catch (e) {
      showErrorToast(message: e.toString());
      log(e.toString());
      emit(GetClientProfileError());
    }
  }

  Future<File?> pickImage() async {
    //print("picking image");
    try{
      File pickedImage;
      final imagePicker = ImagePicker();
      final _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 60);

      if (_pickedImage != null) {
        pickedImage = File(_pickedImage.path);
        return pickedImage;
      }
    } catch(e) {
      showErrorToast(message: e.toString());
      log(e.toString());
    }
    return null;
  }
}
