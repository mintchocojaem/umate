import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class RegisterPageController extends GetxController {

  final RxInt _currentStep = 1.obs;

  final RxBool _check1 = false.obs;
  final RxBool _check2 = false.obs;

  bool get check1 => _check1.value;
  bool get check2 => _check2.value;
  int get currentStep => _currentStep.value;

  set check1(index) => _check1.value = index;
  set check2(index) => _check2.value = index;
  set currentStep(index) => _currentStep.value = index;

  final TextEditingController studentIdController = TextEditingController();
  final RxString _studentId = ''.obs;
  String get studentId => _studentId.value;
  set studentId(index) => _studentId.value = index;

  final TextEditingController studentPasswordController = TextEditingController();
  final RxString _studentPassword = ''.obs;
  String get studentPassword => _studentPassword.value;
  set studentPassword(index) => _studentPassword.value = index;

  final TextEditingController passwordController = TextEditingController();
  final RxString _password = ''.obs;
  String get password => _password.value;
  set password(index) => _password.value = index;

  final TextEditingController passwordValidateController = TextEditingController();
  final RxString _passwordValidate = ''.obs;
  String get passwordValidate => _passwordValidate.value;
  set passwordValidate(index) => _passwordValidate.value = index;

  final TextEditingController nicknameController = TextEditingController();
  final RxString _nickname = ''.obs;
  String get nickname => _nickname.value;
  set nickname(index) => _nickname.value = index;

  final TextEditingController phoneNumberController = TextEditingController();
  final RxString _phoneNumber = ''.obs;
  String get phoneNumber => _phoneNumber.value;
  set phoneNumber(index) => _phoneNumber.value = index;

  final TextEditingController phoneAuthenticationNumberController = TextEditingController();
  final RxString _phoneAuthenticationNumber = ''.obs;
  String get phoneAuthenticationNumber => _phoneAuthenticationNumber.value;
  set phoneAuthenticationNumber(index) => _phoneAuthenticationNumber.value = index;

  @override
  void onInit() {
    // TODO: implement onInit

    studentIdController.addListener(() {
      studentId = studentIdController.text;
    });

    studentPasswordController.addListener(() {
      studentPassword = studentPasswordController.text;
    });

    passwordController.addListener(() {
      password = passwordController.text;
    });

    passwordValidateController.addListener(() {
      passwordValidate = passwordValidateController.text;
    });

    nicknameController.addListener(() {
      nickname = nicknameController.text;
    });

    phoneNumberController.addListener(() {
      phoneNumber = phoneNumberController.text;
    });

    phoneAuthenticationNumberController.addListener(() {
      phoneAuthenticationNumber = phoneAuthenticationNumberController.text;
    });

    super.onInit();
  }

}
