import 'package:danvery/domain/auth/reigster/model/register_model.dart';
import 'package:danvery/domain/auth/reigster/repository/register_repository.dart';
import 'package:danvery/ui/pages/auth/register_page/views/steps/register_step_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/steps/register_step_2.dart';
import '../views/steps/register_step_3.dart';

class RegisterPageController extends GetxController {

  final RegisterRepository _registerRepository = RegisterRepository();

  List<Widget> pages = const[
    RegisterStep1(),
    RegisterStep2(),
    RegisterStep3(),
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

  final Rx<RegisterModel> _registerModel = RegisterModel().obs;
  final RxBool _isStudentAuthenticated = false.obs;
  final RxBool _isRegistered = false.obs;

  RegisterModel get registerModel => _registerModel.value;

  bool get isStudentAuthenticated => _isStudentAuthenticated.value;
  bool get isRegistered => _isRegistered.value;

  Future<bool> studentAuthenticate(String id, String password) async{
    await _registerRepository.studentAuthenticate(id, password).then((value) {

      if(value == null){
        _isStudentAuthenticated.value = false;
      }else{
        _registerModel.value = value;
        _isStudentAuthenticated.value = true;
      }

    });
    return _isStudentAuthenticated.value;
  }

  Future<bool> register(RegisterModel registerModel) async{
    await _registerRepository.register(registerModel).then((value) {

      if(value == null){
        _isRegistered.value = false;
      }else{
        _registerModel.value = value;
        _isRegistered.value = true;
      }

    });
    return _isStudentAuthenticated.value;
  }

  Future<bool> sendSMSAuth(String signupToken , String phoneNumber) async {
    try {
      final bool isSend = await _registerRepository.sendSMSAuth(signupToken, phoneNumber);
      return isSend;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    try {
      final bool isVerify = await _registerRepository.verifySMSAuth(signupToken, code);
      return isVerify;
    } catch (e) {
      return false;
    }
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
