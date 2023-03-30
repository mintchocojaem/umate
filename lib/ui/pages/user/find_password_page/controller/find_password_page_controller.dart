import 'package:danvery/domain/user/find/repository/find_repository.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/steps/find_password_step_2.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/steps/find_password_step_3.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/steps/find_password_step_4.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/steps/find_password_step_1.dart';

class FindPasswordPageController extends GetxController {
  final FindRepository _findRepository = FindRepository();

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

  final RxString phoneAuthCode = "".obs;

  final RxString password = "".obs;

  final RxString passwordValidate = "".obs;

  late String? token;

  Future<bool> sendAuthCodeToSMS() async{
    return await _findRepository.sendAuthCodeToSMS(
        phoneNumber: phoneNumber.value).then((value){
          if(value != null){
            token = value;
            return true;
          }else{
            token = null;
            return false;
          }
    });
  }

  Future<bool> verifyAuthCode() async{
    return await _findRepository.verifyAuthCode(
        token: token!,
        code: phoneAuthCode.value);
  }

  Future<bool> changePassword() async{
    return await _findRepository.changePassword(
        token: token!,
        password: password.value);
  }

}
