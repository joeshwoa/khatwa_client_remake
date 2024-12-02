import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../old_core/class/statusrequst.dart';
import '../old_core/functions/handlingdata.dart';
import '../dataforcrud/addcarforrent.dart';

class AddCarForRentController extends GetxController{
  StatusRequest statusRequest =StatusRequest.none;
  AddCarForRentData addCarForRentData = AddCarForRentData(Get.find());

  File? file;


  Future uploadimage()async{
    final myfile =await ImagePicker().
    pickImage(source: ImageSource.gallery,imageQuality: 50);
    if(myfile != null){
      return File(myfile.path);
    }else{
    }

  }

  uploadfile()async{
    file = await uploadimage();
    update();
  }
  bool isdriver = false;

  withdriver(){
    isdriver=true;
    update();
  }

  withoutdriver(){
    isdriver=false;
    update();
  }

  addCarData(name,phone,price,carname,
      des,driver,category)
  async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await addCarForRentData.
    postData(name, phone, price,
        carname, des,driver,category,file);
    statusRequest = handlingData(response);
    if(StatusRequest.success == statusRequest){
      Get.defaultDialog(title: "Success",
          middleText: "تم اضافة السيارة بنجاح",onConfirm: (){
            Get.back();
          });
    }else{
      Get.defaultDialog(title: "تنبية",
          middleText: "تاكد من البيانات بشكل صحيح",onConfirm: (){
            // navigateOff(MainView());
            Get.back();
          });
     
      statusRequest = StatusRequest.failure;

    }
    update();
  }
}
