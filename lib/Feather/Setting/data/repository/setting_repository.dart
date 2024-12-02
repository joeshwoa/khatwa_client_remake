import 'package:khatwa_client/Core/api/constant_api.dart';
import 'package:khatwa_client/Core/api/http_services.dart';

class SettingRepository {
  static Future getBanners({required String token}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}advertisement',);
    Map<String, dynamic> data = await HttpService.get(uri: uri, headers: {
      'Content-Type': 'application/json',
      'AUTHORIZATION': 'Bearer $token',
    });
    return data;
  }
}