import 'package:get/get.dart';

class AuthenticationController extends GetxController {

  static AuthenticationController get to => Get.find();

  final RxBool _isAuthenticated = false.obs;

  get isAuthenticated => _isAuthenticated.value;

  Future<void> authenticate() async{
    _isAuthenticated.value = true;
  }

}
