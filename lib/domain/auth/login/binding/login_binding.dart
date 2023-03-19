import 'package:danvery/domain/auth/login/services/login_service.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:get/get.dart';

import '../provider/login_provider.dart';
import '../repository/login_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginService>(LoginService(
        loginRepository: LoginRepository(
            loginProvider: LoginProvider(dio: DioInterceptor().dio))));
  }
}
