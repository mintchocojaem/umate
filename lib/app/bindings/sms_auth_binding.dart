import 'package:get/get.dart';

import '../controller/sms_auth_controller.dart';
import '../data/provider/sms_auth_provider.dart';
import '../data/repository/sms_auth_repository.dart';

class SMSAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SMSAuthController>(() => SMSAuthController(
        smsAuthRepository:
            SMSAuthRepository(smsAuthProvider: SMSAuthProvider())));
  }
}
