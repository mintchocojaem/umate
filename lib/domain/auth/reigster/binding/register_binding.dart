import 'package:get/get.dart';

import '../controller/register_controller.dart';
import '../repository/register_repository.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(registerRepository: RegisterRepository()));
  }
}
