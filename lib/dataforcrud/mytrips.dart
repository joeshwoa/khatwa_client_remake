import '../old_core/class/crud.dart';

import '../old_core/contants/api.dart';

class MyTripsData{
  Crud crud;
  MyTripsData(this.crud);
  getData()async{
    var response = await crud.getData(getMyTrips);
    return response.fold((left) => left, (right) => right);
  }

}