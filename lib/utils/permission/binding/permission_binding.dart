import 'package:get/get.dart';

import '../controller/permission_controller.dart';

class PermissionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PermissionController>(() => PermissionController());
  }
}
