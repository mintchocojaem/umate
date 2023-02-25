import 'package:danvery/app/controller/register_controller.dart';
import 'package:get/get.dart';

import '../controller/authentication_controller.dart';
import '../controller/home_controller.dart';
import '../controller/login_controller.dart';
import '../controller/main_controller.dart';
import '../data/provider/board_provider.dart';
import '../data/provider/login_provider.dart';
import '../data/repository/board_repository.dart';
import '../data/repository/login_repository.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController(
        boardRepository: BoardRepository(boardProvider: BoardProvider())));
    Get.lazyPut<AuthenticationController>(() => AuthenticationController());
    Get.lazyPut(() => LoginController(
        loginRepository: LoginRepository(loginProvider: LoginProvider())));
    Get.lazyPut(() => RegisterController());
  }
}
