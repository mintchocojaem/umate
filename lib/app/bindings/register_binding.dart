import 'package:danvery/app/data/repository/register_repository.dart';
import 'package:get/get.dart';

import '../controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(registerRepository: RegisterRepository()));
  }
}
