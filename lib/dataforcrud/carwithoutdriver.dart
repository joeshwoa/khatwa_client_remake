
import '../old_core/contants/api.dart';

import '../old_core/class/crud.dart';

class CarWithOutDriverData{
  Crud crud;
  CarWithOutDriverData(this.crud);

  getData(id)async{
    var response = await crud.getData(carsWithoutDriver(id));
    return response.fold((left) => left, (right) => right);
  }
}