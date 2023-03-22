import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/steps/find_password_step_1.dart';

class FindPasswordPageController extends GetxController {

  List<String> stepTitle = [
    "휴대폰 번호 입력",
    "인증번호 입력",
    "비밀번호 재설정",
    "비밀번호 변경이\n 완료되었습니다"
  ];

  List<Widget> pages = const [
    FindPasswordStep1(),
  ];

  final RxInt _currentStep = 1.obs;

  int get currentStep => _currentStep.value;

  set currentStep(index) => _currentStep.value = index;

  final TextEditingController phoneNumberController = TextEditingController();
  final RxString _phoneNumber = ''.obs;
  String get phoneNumber => _phoneNumber.value;
  set phoneNumber(index) => _phoneNumber.value = index;

}
