import 'package:danvery/core/dto/api_response_dto.dart';
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

  final Rx<TextEditingController> studentIdController =
      TextEditingController().obs;

  final Rx<TextEditingController> studentPasswordController =
      TextEditingController().obs;

  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;

  final Rx<TextEditingController> passwordValidateController =
      TextEditingController().obs;

  final Rx<TextEditingController> nicknameController =
      TextEditingController().obs;

  final Rx<TextEditingController> phoneNumberController =
      TextEditingController().obs;

  final Rx<TextEditingController> phoneAuthenticationNumberController =
      TextEditingController().obs;

  late Rx<RegisterModel> registerInfo;
  final RxBool isStudentAuthenticated = false.obs;
  final RxBool isRegistered = false.obs;

  Future<void> studentAuthenticate(String id, String password) async {
    final ApiResponseDTO apiResponseDTO =
        await _registerRepository.studentAuth(id: id, password: password);
    if (apiResponseDTO.success) {
      final RegisterModel registerModel = apiResponseDTO.data as RegisterModel;
      registerInfo = registerModel.obs;
      isStudentAuthenticated.value = true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "학생인증 오류",
              content: apiResponseDTO.message)
          .show();
      isStudentAuthenticated.value = false;
    }
  }

  Future<void> register() async {
    final ApiResponseDTO apiResponseDTO =
        await _registerRepository.register(registerModel: registerInfo.value);
    if (apiResponseDTO.success) {
      final RegisterModel registerModel = apiResponseDTO.data as RegisterModel;
      registerInfo = registerModel.obs;
      isRegistered.value = true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "회원가입 오류",
              content: apiResponseDTO.message)
          .show();
      isRegistered.value = false;
    }
  }

  Future<bool> sendSMSAuth(String signupToken, String phoneNumber) async {
    final ApiResponseDTO apiResponseDTO = await _registerRepository
        .sendAuthCodeToSMS(signupToken: signupToken, phoneNumber: phoneNumber);
    if (apiResponseDTO.success) {
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "인증번호 전송 성공",
              content: "인증번호가 전송되었습니다. 휴대폰을 확인해주세요")
          .show();
      return true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "인증번호 전송 오류",
              content: apiResponseDTO.message)
          .show();
      return false;
    }
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    final ApiResponseDTO apiResponseDTO = await _registerRepository
        .verifyAuthCodeToSMS(signupToken: signupToken, code: code);
    if (apiResponseDTO.success) {
      return true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "인증번호 확인 오류",
              content: apiResponseDTO.message)
          .show();
      return false;
    }
  }
}
