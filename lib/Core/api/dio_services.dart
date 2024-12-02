import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:khatwa_client/Core/services/shared_pref_services.dart';
import 'package:khatwa_client/Core/unit/constant_data.dart';

class DioService{
  static Future<dynamic> postMultiPart({required Uri uri, Map<String,dynamic>? body, Map<String,String>? headers , Map<String,dynamic>? queryParams}) async {
    Map<String,String>? header={
      'Accept':'application/json',
      'Content-Type':'multipart/form-data',
      'Accept-Language':SharedPreferencesServices.getData(key: ConstantData.kLung)??ConstantData.kDefaultLung
    };
    header.addEntries(headers?.entries??{});

    Map<String,dynamic> modifiedBody = {};
    body?.forEach(
          (key, value) async {
            if(value is File) {
              modifiedBody[key] = await MultipartFile.fromFile(value.path, filename: "image.jpg");
            } else {
              modifiedBody[key] = value;
            }
          },
    );

    FormData finalBody = FormData.fromMap(modifiedBody);

    final dio = Dio();
    dio.options.headers.addAll(header);

    Response response = await dio.postUri(uri.replace(
        queryParameters: queryParams
    ), data: finalBody,);
    Map<String, dynamic> data = jsonDecode(response.data);
    data.addAll({'statusCode': response.statusCode});
    return data;
  }

  static Future<dynamic> putMultiPart({required Uri uri, Map<String,dynamic>? body, Map<String,String>? headers, Map<String,dynamic>? queryParams}) async {
    Map<String,String>? header={
      'Accept':'application/json',
      'Content-Type':'multipart/form-data',
      'Accept-Language':SharedPreferencesServices.getData(key: ConstantData.kLung)??ConstantData.kDefaultLung
    };
    header.addEntries(headers?.entries??{});

    Map<String,dynamic> modifiedBody = {};
    body?.forEach(
          (key, value) async {
        if(value is File) {
          modifiedBody[key] = await MultipartFile.fromFile(value.path, filename: "image.jpg");
        } else {
          modifiedBody[key] = value;
        }
      },
    );

    FormData finalBody = FormData.fromMap(modifiedBody);

    final dio = Dio();
    dio.options.headers.addAll(header);

    Response response = await dio.putUri(uri.replace(
        queryParameters: queryParams
    ), data: finalBody,);
    Map<String, dynamic> data = jsonDecode(response.data);
    data.addAll({'statusCode': response.statusCode});
    return data;
  }

  static Future<dynamic> patchMultiPart({required Uri uri, Map<String,dynamic>? body, Map<String,String>? headers, Map<String,dynamic>? queryParams}) async {
    Map<String,String>? header={
      'Accept':'application/json',
      'Content-Type':'multipart/form-data',
      'Accept-Language':SharedPreferencesServices.getData(key: ConstantData.kLung)??ConstantData.kDefaultLung
    };
    header.addEntries(headers?.entries??{});

    Map<String,dynamic> modifiedBody = {};
    body?.forEach(
          (key, value) async {
        if(value is File) {
          modifiedBody[key] = await MultipartFile.fromFile(value.path, filename: "image.jpg");
        } else {
          modifiedBody[key] = value;
        }
      },
    );

    FormData finalBody = FormData.fromMap(modifiedBody);

    final dio = Dio();
    dio.options.headers.addAll(header);

    Response response = await dio.patchUri(uri.replace(
        queryParameters: queryParams
    ), data: finalBody,);
    Map<String, dynamic> data = jsonDecode(response.data);
    data.addAll({'statusCode': response.statusCode});
    return data;
  }
}