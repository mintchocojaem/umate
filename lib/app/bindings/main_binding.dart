import 'package:danvery/app/bindings/home_binding.dart';
import 'package:get/get.dart';
import '../controller/main_controller.dart';
import '../data/provider/login_provider.dart';
import '../data/repository/login_repository.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController(
        loginRepository: LoginRepository(loginProvider: LoginProvider())));
  }
}
