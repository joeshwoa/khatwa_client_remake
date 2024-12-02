import 'dart:io';

import 'package:khatwa_client/Core/api/constant_api.dart';
import 'package:khatwa_client/Core/api/dio_services.dart';
import 'package:khatwa_client/Core/api/http_services.dart';

class ProfileRepository {
  static Future getClientProfile({required String token}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}user/profile',);
    Map<String, dynamic> data = await HttpService.get(uri: uri, headers: {
      'Content-Type': 'application/json',
      'AUTHORIZATION': 'Bearer $token',
    });
    return data;
  }

  static Future updateClientProfile({required String token, String? name, String? phone}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}user/updateInfo',);
    Map<String, dynamic> data = await HttpService.patch(uri: uri, headers: {
      'Content-Type': 'application/json',
      'AUTHORIZATION': 'Bearer $token',
    }, body: {
      if(name != null)"name": name,
      if(phone != null)"phone": phone,
    });
    return data;
  }

  static Future updateClientProfileAvatar({required String token, required File image}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}user/changePicture',);
    Map<String, dynamic> data = await DioService.patchMultiPart(uri: uri, headers: {
      'Content-Type': 'multipart/form-data',
      'AUTHORIZATION': 'Bearer $token',
    }, body: {
      "image": image
    });
    return data;
  }
}