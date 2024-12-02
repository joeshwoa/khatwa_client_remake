import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khatwa_client/Core/services/shared_pref_services.dart';
import 'package:khatwa_client/Core/unit/constant_data.dart';

class HttpService{
  static Future<dynamic> get({required Uri uri, Map<String,String>? headers, Map<String,dynamic>? queryParams,})async{
    Map<String,String>? header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Accept-Language':SharedPreferencesServices.getData(key: ConstantData.kLung)??ConstantData.kDefaultLung
    };
    header.addEntries(headers?.entries??{});

    http.Response response=await http.get(uri.replace(
        queryParameters: queryParams
    ),headers:header );
    Map<String, dynamic> data = jsonDecode(response.body);
    data.addAll({'statusCode': response.statusCode});
    return data;
  }

  static Future<dynamic> post({required Uri uri, Map<String,dynamic>? body, Map<String,String>? headers, Map<String,dynamic>? queryParams}) async {
    Map<String,String>? header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Accept-Language':SharedPreferencesServices.getData(key: ConstantData.kLung)??ConstantData.kDefaultLung
    };
    header.addEntries(headers?.entries??{});
    http.Response response = await http.post(uri.replace(
        queryParameters: queryParams
    ), body: json.encode(body),headers:header );
    Map<String, dynamic> data = jsonDecode(response.body);
    data.addAll({'statusCode': response.statusCode});
    return data;
  }

  static Future<dynamic> delete({required Uri uri, Map<String,dynamic>? body, Map<String,String>? headers, Map<String,dynamic>? queryParams}) async {
    Map<String,String>? header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Accept-Language':SharedPreferencesServices.getData(key: ConstantData.kLung)??ConstantData.kDefaultLung
    };
    header.addEntries(headers?.entries??{});
    http.Response response = await http.delete(uri.replace(
        queryParameters: queryParams
    ), body: json.encode(body),headers:header );
    Map<String, dynamic> data = jsonDecode(response.body);
    data.addAll({'statusCode': response.statusCode});
    return data;
  }

  static Future<dynamic> put({required Uri uri, Map<String,dynamic>? body, Map<String,String>? headers, Map<String,dynamic>? queryParams,}) async {
    Map<String,String>? header={
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Accept-Language': SharedPreferencesServices.getData(key: ConstantData.kLung)??ConstantData.kDefaultLung
    };
    header.addEntries(headers?.entries??{});
    http.Response response = await http.put(uri.replace(
        queryParameters: queryParams
    ), body: json.encode(body),headers:header);
    Map<String, dynamic> data = jsonDecode(response.body);
    data.addAll({'statusCode': response.statusCode});
    return data;
  }

  static Future<dynamic> patch({required Uri uri, Map<String,dynamic>? body, Map<String,String>? headers}) async {
    Map<String,String>? header={
      'Accept':'application/json',
      'Content-Type':'application/json',
    };
    header.addEntries(headers?.entries??{});
    http.Response response = await http.patch(uri, body: json.encode(body), headers:header);
    Map<String, dynamic> data = jsonDecode(response.body);
    data.addAll({'statusCode': response.statusCode});
    return data;
  }
}