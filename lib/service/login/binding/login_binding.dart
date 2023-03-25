import 'package:danvery/service/login/login_service.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginService>(LoginService());
  }
}
