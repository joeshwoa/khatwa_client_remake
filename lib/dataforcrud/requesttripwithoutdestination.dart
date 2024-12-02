
import 'dart:io';

import 'package:get/get.dart';

import '../old_core/class/crud.dart';
import '../old_core/contants/api.dart';

class RequestTripWithoutDestinationData{
  Crud crud;
  RequestTripWithoutDestinationData(this.crud);
  postData(driverid,lan,log)
  async{
    var response = await crud.postData(requestTrip,{
      "driverId":driverid.toString(),
      "pickupLatitude":lan,
      "pickupLongitude":log,
    });
    return response.fold((left) {
    }, (right) => right);
  }

}