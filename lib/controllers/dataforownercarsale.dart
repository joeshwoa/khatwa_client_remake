import 'package:get/get.dart';

import '../old_core/class/statusrequst.dart';
import '../old_core/functions/handlingdata.dart';
import '../dataforcrud/dataforownersalecar.dart';
import '../models/ownercarsalemodel.dart';

class OwnerCarForSaleController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  OwnerDataForSaleCar ownerData = OwnerDataForSaleCar(Get.find());
  late OwnerModel ownerModel;
  getownerdata(id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await ownerData.getData(id);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      ownerModel = OwnerModel.fromJson(response['owner']);
    } else {}
    update();
  }
}
