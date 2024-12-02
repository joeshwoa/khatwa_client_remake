import 'dart:convert';
import 'dart:core';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../old_core/contants/api.dart';
import '../../../old_core/functions/checkinternet.dart';
import '../../../old_core/services/cache_storage_services.dart';
import '../model/ads_model.dart';

class AdsController extends GetxController {
  var isLoading = false.obs;
  var allAdsDataError = ''.obs;
  RxList<AdsModel> allAdsList = <AdsModel>[].obs;

  Future<void> getAllAdsData() async {
    if (await checkInternet()) {
      try {
        isLoading.value = true;
        allAdsList.value = <AdsModel>[].obs;
        final response = await http.get(
          getAllAdsUri,
          headers: authHeadersWithToken(CacheStorageServices().token),
        );
        final result = jsonDecode(response.body);

        if (response.statusCode == 200) {
        
          var r = result['ads'] as List;
          r.map((e) {
            allAdsList.add(AdsModel.fromJson(e));
          }).toList();
          allAdsList.isEmpty
              ? allAdsDataError.value = 'لا يوجد بيانات'
              : allAdsDataError.value = '';
          isLoading.value = false;
        } else {
          isLoading.value = false;
          allAdsDataError.value = result['message'];
        }
      } catch (e) {
       
        isLoading.value = false;
        allAdsDataError.value = e.toString();
      }
    } else {
      allAdsDataError.value = 'لا يوجد اتصال بالانترنت';
    }
    
  }

  RxString searchText = ''.obs;
  List get filteredList {
    if (searchText.value.isEmpty) {
      return [];
    } else {
      return allAdsList.where((item) {
        var name = item.name ?? '';
        return name.toLowerCase().startsWith(searchText.value.toLowerCase());
      }).toList();
    }
  }
}
