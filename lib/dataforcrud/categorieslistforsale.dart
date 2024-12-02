import '../old_core/class/crud.dart';
import '../old_core/contants/api.dart';

class CategoriesListForSaleData {
  Crud crud;
  CategoriesListForSaleData(this.crud);

  getData(id) async {
    var response = await crud.getData(categoriesList(id));
    return response.fold((left) => left, (right) => right);
  }
}
