import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  final LoginService loginService = Get.find<LoginService>();

  final Rx<TextEditingController> idController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;

  final RxBool isPasswordVisible = false.obs;

  DateTime preBackpressure = DateTime.now();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void initLoginPage(){
    idController.value.clear();
    passwordController.value.clear();
    refresh();
  }

  Future<void> login() async {

    await loginService.login(
        idController.value.text,
        passwordController.value.text);
    if (loginService.isLogin.value) {
      Get.back();
      Get.offAndToNamed(Routes.main);
    }
  }

}
