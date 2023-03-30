import 'package:danvery/domain/user/reigster/model/register_model.dart';
import 'package:danvery/domain/user/reigster/repository/register_repository.dart';
import 'package:danvery/ui/pages/user/register_page/views/steps/register_step_1.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
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
      if (value.success) {
        registerModel.value = value.data as RegisterModel;
        isStudentAuthenticated.value = true;
      } else {
        GetXSnackBar(
            type: GetXSnackBarType.customError,
            title: "학생인증 오류",
            content: value.message
        ).show();
        isStudentAuthenticated.value = false;
      }
    });
    return isStudentAuthenticated.value;
  }

  Future<bool> register(RegisterModel model) async {
    await _registerRepository.register(registerModel: model).then((value) {
      if (value.success) {
        isRegistered.value = false;
        registerModel.value = value.data as RegisterModel;
        isRegistered.value = true;
      } else {
        GetXSnackBar(
            type: GetXSnackBarType.customError,
            title: "회원가입 오류",
            content: value.message
        ).show();
        isRegistered.value = false;
      }
    });
    return isStudentAuthenticated.value;
  }

  Future<bool> sendSMSAuth(String signupToken, String phoneNumber) async {
    return await _registerRepository
        .sendAuthCodeToSMS(signupToken: signupToken, phoneNumber: phoneNumber)
        .then((value) {
      if (value.success) {
        return true;
      } else {
        GetXSnackBar(
          type: GetXSnackBarType.customError,
          title: "인증번호 전송 오류",
          content: value.message
        ).show();
        return false;
      }
    });
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    return await _registerRepository
        .verifyAuthCodeToSMS(signupToken: signupToken, code: code)
        .then((value) {
      if (value.success) {
        return true;
      } else {
        GetXSnackBar(
          type: GetXSnackBarType.customError,
          title: "인증번호 확인 오류",
          content: value.message
        ).show();
        return false;
      }
    });
  }
}
