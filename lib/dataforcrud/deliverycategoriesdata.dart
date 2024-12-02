
import '../old_core/contants/api.dart';

import '../old_core/class/crud.dart';

class DeliveryCategoriesData{
  Crud crud;
  DeliveryCategoriesData(this.crud);

  getDeliveryCategoryData()async{
    var response = await crud.getData(deliverycategories);
    return response.fold((left) => left, (right) => right);
  }
}