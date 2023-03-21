import 'package:danvery/domain/auth/login/service/login_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../utils/permission/service/permission_service.dart';

class MyPagePageController extends GetxController{
  final PermissionService permissionService = Get.find<PermissionService>();
  final LoginService loginService = Get.find<LoginService>();
}
