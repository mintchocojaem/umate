import 'package:get/get.dart';

import '../service/permission_service.dart';


class PermissionBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<PermissionService>(PermissionService());
  }
}
