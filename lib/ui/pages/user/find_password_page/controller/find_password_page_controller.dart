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

  final RxString phoneNumber = "".obs;

  final RxString phoneAuthenticationNumber = "".obs;

  final RxString password = "".obs;

  final RxString passwordValidate = "".obs;

  Future<bool> verifySMS(String code) async {
    try {
      //final bool isVerify = await ;
      return true;
    } catch (e) {
      return false;
    }
  }

}
