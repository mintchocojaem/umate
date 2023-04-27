import 'package:danvery/service/login/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController{

  final LoginService loginService = Get.find<LoginService>();

  final Rx<TextEditingController> idController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController = TextEditingController().obs;

  final RxBool isPasswordVisible = false.obs;

}
