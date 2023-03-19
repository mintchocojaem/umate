import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../domain/auth/reigster/controller/register_controller.dart';
import '../views/screens/member_info_screen.dart';
import '../views/screens/register_success_screen.dart';
import '../views/screens/student_auth_screen.dart';

class RegisterPageController extends GetxController {

  List<Widget> pages = const[
    StudentAuthScreen(),
    MemberInfoScreen(),
    RegisterSuccessScreen()
  ];

  List<String> stepTitle = ["학생인증", "회원 정보 입력", "가입이 \n완료되었습니다"];

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

  final RegisterController registerController = Get.find<RegisterController>();

  // 3~16자 영문 대소문자, 한글, 숫자, 특수문자(_), 공백 조합
  bool isValidNicknameFormat(String nickname) {
    return RegExp(r"^(?!.*\s{2,})[A-Za-z\dㄱ-ㅎㅏ-ㅣ가-힣_ ]{3,16}$")
        .hasMatch(nickname);
  }

  // 8~16자 영문 대소문자, 숫자, 특수문자(!@#$%^&*+=\-_(){}[\]:;<>,.?~) 조합
  bool isValidPasswordFormat(String password) {
    return RegExp(
        r"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*+=\-_(){}[\]:;<>,.?~]{8,16}$")
        .hasMatch(password);
  }

  //대시(-)를 포함하거나 포함하지 않는 11자리 010 휴대폰 번호
  bool isValidPhoneNumberFormat(String phoneNumber) {
    return RegExp(r'^010-?\d{4}-?\d{4}$').hasMatch(phoneNumber);
  }


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
