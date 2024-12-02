
import 'dart:io';


import '../old_core/class/crud.dart';
import '../old_core/contants/api.dart';

class AddCarForSaleData{
  Crud crud;
  AddCarForSaleData(this.crud);

  postData(name,phone,price,carname,des,category,File? image)
  async{
    var response = await crud.postDataWithFile(addCarForSale,
       {
         "name":name,
         "phone":phone,
         "facebook":"f",
         "telegram":"t",
         "price":price,
         "carName":carname,
         "description":des,
         "category":category,
       }, image);
    return response.fold((left) {
    }, (right) => right);
  }

}