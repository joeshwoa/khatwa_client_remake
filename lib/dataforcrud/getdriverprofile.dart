import '../old_core/class/crud.dart';

import '../old_core/contants/api.dart';

class DriverProfileData{
  Crud crud;
  DriverProfileData(this.crud);
  getData(id)async{
    var response = await crud.getData(getdriverProfile(id));
    return response.fold((left) => left, (right) => right);
  }

}