import 'package:danvery/domain/user/reigster/repository/register_repository.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/steps/find_password_step_2.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/steps/find_password_step_3.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/steps/find_password_step_4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/steps/find_password_step_1.dart';

class FindPasswordPageController extends GetxController {

  final RegisterRepository _registerRepository = RegisterRepository();

  List<String> stepTitle = [
    "휴대폰 번호 입력",
    "인증번호 입력",
    "비밀번호 재설정",
    "비밀번호 변경이\n완료되었습니다"
  ];

  List<Widget> pages = const [
    FindPasswordStep1(),
    FindPasswordStep2(),
    FindPasswordStep3(),
    FindPasswordStep4(),
  ];

  final RxInt currentStep = 1.obs;

  final TextEditingController phoneNumberController = TextEditingController();
  final RxString phoneNumber = ''.obs;

  final TextEditingController phoneAuthenticationNumberController = TextEditingController();
  final RxString phoneAuthenticationNumber = ''.obs;

  final TextEditingController passwordController = TextEditingController();
  final RxString password = ''.obs;

  final TextEditingController passwordValidateController = TextEditingController();
  final RxString passwordValidate = ''.obs;

  @override
  void onInit() {
    phoneNumberController.addListener(() {
      phoneNumber.value = phoneNumberController.text;
    });
    phoneAuthenticationNumberController.addListener(() {
      phoneAuthenticationNumber.value = phoneAuthenticationNumberController.text;
    });
    passwordController.addListener(() {
      password.value = passwordController.text;
    });
    passwordValidateController.addListener(() {
      passwordValidate.value = passwordValidateController.text;
    });
    super.onInit();
  }

  Future<bool> verifySMS(String code) async {
    try {
      //final bool isVerify = await ;
      return true;
    } catch (e) {
      return false;
    }
  }

}
