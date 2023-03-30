import 'package:danvery/domain/user/reigster/model/register_model.dart';
import 'package:danvery/domain/user/reigster/repository/register_repository.dart';
import 'package:danvery/ui/pages/user/register_page/views/steps/register_step_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/steps/register_step_2.dart';
import '../views/steps/register_step_3.dart';

class RegisterPageController extends GetxController {
  final RegisterRepository _registerRepository = RegisterRepository();

  List<Widget> pages = const [
    RegisterStep1(),
    RegisterStep2(),
    RegisterStep3(),
  ];

  List<String> stepTitle = ["학생인증", "회원 정보 입력", "가입이 \n완료되었습니다"];

  final RxInt currentStep = 1.obs;

  final RxBool check1 = false.obs;
  final RxBool check2 = false.obs;

  final ScrollController scrollController = ScrollController();

  final RxString studentId = "".obs;

  final RxString studentPassword = "".obs;

  final RxString password = "".obs;

  final RxString passwordValidate = "".obs;

  final RxString nickname = "".obs;

  final RxString phoneNumber = "".obs;

  final RxString phoneAuthenticationNumber = "".obs;

  final Rx<RegisterModel> registerModel = RegisterModel().obs;
  final RxBool isStudentAuthenticated = false.obs;
  final RxBool isRegistered = false.obs;

  Future<bool> studentAuthenticate(String id, String password) async {
    await _registerRepository
        .studentAuth(id: id, password: password)
        .then((value) {
      if (value == null) {
        isStudentAuthenticated.value = false;
      } else {
        registerModel.value = value;
        isStudentAuthenticated.value = true;
      }
    });
    return isStudentAuthenticated.value;
  }

  Future<bool> register(RegisterModel model) async {
    await _registerRepository
        .register(registerModel: model)
        .then((value) {
      if (value == null) {
        isRegistered.value = false;
      } else {
        registerModel.value = value;
        isRegistered.value = true;
      }
    });
    return isStudentAuthenticated.value;
  }

  Future<bool> sendSMSAuth(String signupToken, String phoneNumber) async {
    try {
      final bool isSend = await _registerRepository.sendAuthCodeToSMS(
          signupToken: signupToken, phoneNumber: phoneNumber);
      return isSend;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    try {
      final bool isVerify = await _registerRepository.verifyAuthCodeToSMS(
          signupToken: signupToken, code: code);
      return isVerify;
    } catch (e) {
      return false;
    }
  }

}
