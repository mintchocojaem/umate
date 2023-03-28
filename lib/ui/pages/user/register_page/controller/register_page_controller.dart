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

  final TextEditingController studentIdController = TextEditingController();
  final RxString studentId = ''.obs;

  final TextEditingController studentPasswordController =
      TextEditingController();
  final RxString studentPassword = ''.obs;

  final TextEditingController passwordController = TextEditingController();
  final RxString password = ''.obs;

  final TextEditingController passwordValidateController =
      TextEditingController();
  final RxString passwordValidate = ''.obs;

  final TextEditingController nicknameController = TextEditingController();
  final RxString nickname = ''.obs;

  final TextEditingController phoneNumberController = TextEditingController();
  final RxString phoneNumber = ''.obs;

  final TextEditingController phoneAuthenticationNumberController =
      TextEditingController();
  final RxString phoneAuthenticationNumber = ''.obs;

  final Rx<RegisterModel> registerModel = RegisterModel().obs;
  final RxBool isStudentAuthenticated = false.obs;
  final RxBool isRegistered = false.obs;

  Future<bool> studentAuthenticate(String id, String password) async {
    await _registerRepository
        .studentAuthenticate(id: id, password: password)
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
      final bool isSend = await _registerRepository.sendSMSAuth(
          signupToken: signupToken, phoneNumber: phoneNumber);
      return isSend;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    try {
      final bool isVerify = await _registerRepository.verifySMSAuth(
          signupToken: signupToken, code: code);
      return isVerify;
    } catch (e) {
      return false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    studentIdController.addListener(() {
      studentId.value = studentIdController.text;
    });

    studentPasswordController.addListener(() {
      studentPassword.value = studentPasswordController.text;
    });

    passwordController.addListener(() {
      password.value = passwordController.text;
    });

    passwordValidateController.addListener(() {
      passwordValidate.value = passwordValidateController.text;
    });

    nicknameController.addListener(() {
      nickname.value = nicknameController.text;
    });

    phoneNumberController.addListener(() {
      phoneNumber.value = phoneNumberController.text;
    });

    phoneAuthenticationNumberController.addListener(() {
      phoneAuthenticationNumber.value = phoneAuthenticationNumberController.text;
    });

    super.onInit();
  }
}
