import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../../old_core/contants/api.dart';
import '../../../../old_core/helper/notifictions_helper.dart';
import '../../../../old_core/services/cache_storage_services.dart';

class ClientAuthRepo {
  Future<Either<String, String>> clientLoginRepo(
      String phone, String password) async {
    try {

      final response = await http.post(
        clientLogin,
        body: jsonEncode({'phone': phone, 'password': password,
          "deviceToken":await FirebaseMessagingService.getDeviceToken()}),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (result['message'] == 'LoggedIn successfully') {
          CacheStorageServices().setToken(result['token']);
          CacheStorageServices().setId(result['user']['_id']);
        }
        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> clientRegisterRepo(
      String name,String phone) async {
    try {
      final response = await http.post(
        clientRegister,
        body: jsonEncode({
          'phone': phone,
          'name': name,
          "deviceToken":await FirebaseMessagingService.getDeviceToken()}),
        headers: authHeaders,
      );
      final result = jsonDecode(response.body);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Right(result['message']);
      } else {
        return Left(result['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
