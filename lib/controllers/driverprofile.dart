import 'package:get/get.dart';
import '../old_core/class/statusrequst.dart';
import '../dataforcrud/getdriverprofile.dart';

import '../old_core/functions/handlingdata.dart';

class DriverProfileController extends GetxController{
StatusRequest statusRequest =StatusRequest.none;

DriverProfileData driverProfileData = DriverProfileData(Get.find());

getDriver(id)async{
  statusRequest = StatusRequest.loading;
  update();
  var response = await driverProfileData.getData(id);
  statusRequest = handlingData(response);
  if(StatusRequest.success == statusRequest){

  }else{
  }
  update();
}


}