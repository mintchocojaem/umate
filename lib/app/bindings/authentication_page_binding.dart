import 'package:danvery/app/controller/authentication_page_controller.dart';
import 'package:get/get.dart';
import '../controller/board_page_controller.dart';

class AuthenticationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationPageController>(() => AuthenticationPageController());
  }
}
