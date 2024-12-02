import 'package:get/get.dart';

import '../old_core/class/statusrequst.dart';
import '../old_core/functions/handlingdata.dart';
import '../dataforcrud/carwithdriver.dart';

class CarWithDriverController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;

  CarWithDriverData carWithDriverData = CarWithDriverData(Get.find());

  List carswithdriver = [];

  getcarswithdriver(id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await carWithDriverData.getData(id);
    statusRequest = handlingData(response);
    print(response);
    if (StatusRequest.success == statusRequest) {
      carswithdriver.addAll(response['vehicles']);
    } else {}
    update();
  }
}
