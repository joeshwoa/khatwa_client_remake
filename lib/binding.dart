import 'package:get/get.dart';

import 'old_core/class/crud.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
  Get.put(Crud());
  }
}
