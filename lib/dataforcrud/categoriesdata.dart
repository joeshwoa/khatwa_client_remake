import '../old_core/class/crud.dart';

import '../old_core/contants/api.dart';

class CategoriesData{
  Crud crud;
  CategoriesData(this.crud);

  getData()async{
    var response = await crud.getData(categoriesUrL);
    return response.fold((left) => left, (right) => right);
  }

}