import 'package:danvery/app/data/repository/login_repository.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import '../data/provider/login_provider.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController(loginRepository: LoginRepository(loginProvider: LoginProvider())), permanent: true);
  }
}
