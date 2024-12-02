

import 'package:khatwa_client/Core/api/constant_api.dart';
import 'package:khatwa_client/Core/api/http_services.dart';

class HomeRepository {
  static Future getCategories() async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}category',);
    Map<String, dynamic> data = await HttpService.get(uri: uri);
    return data;
  }
}