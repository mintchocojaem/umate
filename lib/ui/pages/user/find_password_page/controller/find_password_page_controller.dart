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

  final RxInt _currentStep = 1.obs;

  int get currentStep => _currentStep.value;

  set currentStep(index) => _currentStep.value = index;

  final TextEditingController phoneNumberController = TextEditingController();
  final RxString _phoneNumber = ''.obs;
  String get phoneNumber => _phoneNumber.value;
  set phoneNumber(index) => _phoneNumber.value = index;

  final TextEditingController phoneAuthenticationNumberController = TextEditingController();
  final RxString _phoneAuthenticationNumber = ''.obs;
  String get phoneAuthenticationNumber => _phoneAuthenticationNumber.value;
  set phoneAuthenticationNumber(index) => _phoneAuthenticationNumber.value = index;

  final TextEditingController passwordController = TextEditingController();
  final RxString _password = ''.obs;
  String get password => _password.value;
  set password(index) => _password.value = index;

  final TextEditingController passwordValidateController = TextEditingController();
  final RxString _passwordValidate = ''.obs;
  String get passwordValidate => _passwordValidate.value;
  set passwordValidate(index) => _passwordValidate.value = index;

  @override
  void onInit() {
    phoneNumberController.addListener(() {
      phoneNumber = phoneNumberController.text;
    });
    phoneAuthenticationNumberController.addListener(() {
      phoneAuthenticationNumber = phoneAuthenticationNumberController.text;
    });
    passwordController.addListener(() {
      password = passwordController.text;
    });
    passwordValidateController.addListener(() {
      passwordValidate = passwordValidateController.text;
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
