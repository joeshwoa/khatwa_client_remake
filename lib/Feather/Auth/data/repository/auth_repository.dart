import 'package:khatwa_client/Core/api/constant_api.dart';
import 'package:khatwa_client/Core/api/http_services.dart';

class AuthRepository {
  static Future login({required String phone, required String deviceToken}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}auth/login/client',);
    Map<String, dynamic> data = await HttpService.post(uri: uri, body: {
      "phone": phone,
      "deviceToken": deviceToken,
    });
    return data;
  }
  static Future signUp({required String phone, required String name, required String deviceToken}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}auth/signup/client',);
    Map<String, dynamic> data = await HttpService.post(uri: uri, body: {
      "phone": phone,
      "name": name,
      "deviceToken": deviceToken,
    });
    return data;
  }
  static Future verifyWithOTP({required String phone, required String otp, required String deviceToken}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}auth/login/client/verify',);
    Map<String, dynamic> data = await HttpService.post(uri: uri, body: {
      "phone": phone,
      "otp": otp,
      "deviceToken": deviceToken,
    });
    return data;
  }
  static Future resendOTP({required String phone}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}auth/resend_verification_code',);
    Map<String, dynamic> data = await HttpService.post(uri: uri, body: {
      "phone": phone,
    });
    return data;
  }
}