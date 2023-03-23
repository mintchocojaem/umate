import 'package:danvery/domain/auth/login/service/login_service.dart';
import 'package:danvery/utils/permission/service/permission_service.dart';
import 'package:get/get.dart';


class MyPagePageController extends GetxController{
  final PermissionService permissionService = Get.find<PermissionService>();
  final LoginService loginService = Get.find<LoginService>();
}
