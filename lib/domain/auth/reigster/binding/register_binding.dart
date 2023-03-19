import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:get/get.dart';

import '../controller/register_controller.dart';
import '../provider/register_provider.dart';
import '../repository/register_repository.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController(
        registerRepository: RegisterRepository(
            registerProvider: RegisterProvider(dio: DioInterceptor().dio))));
  }
}
