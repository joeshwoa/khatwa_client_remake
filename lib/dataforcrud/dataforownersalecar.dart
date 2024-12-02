import '../old_core/class/crud.dart';

import '../old_core/contants/api.dart';

class OwnerDataForSaleCar{
  Crud crud;
  OwnerDataForSaleCar(this.crud);

  getData(id)async{
    var response = await crud.getData(ownerData(id));
    return response.fold((left) => left, (right) => right);
  }

}