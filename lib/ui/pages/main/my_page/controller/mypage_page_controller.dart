import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/user/change/repository/change_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/service/permission/permission_service.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyPagePageController extends GetxController {
  final PermissionService permissionService = Get.find<PermissionService>();
  final LoginService loginService = Get.find<LoginService>();
  final ChangeRepository _changeRepository = ChangeRepository();

  Rx<TextEditingController> nickname = TextEditingController().obs;
  Rx<TextEditingController> currentPassword = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> passwordValidate = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> phoneAuthenticationNumber = TextEditingController().obs;

  void initPage(){
    nickname.value.text = loginService.userInfo.value.nickname;
    currentPassword.value.clear();
    password.value.clear();
    passwordValidate.value.clear();
    phoneNumber.value.clear();
    phoneAuthenticationNumber.value.clear();
  }

  late String changePhoneNumberToken;

  Future<void> changeNickname() async {
    final ApiResponseDTO apiResponseDTO =
        await _changeRepository.changeNickname(
            accessToken: loginService.token.value.accessToken,
            nickName: nickname.value.text);
    if (apiResponseDTO.success) {
      loginService.userInfo.update((val) {
        val!.nickname = nickname.value.text;
      });
      Get.back();
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "닉네임 변경 성공",
              content: "닉네임이 변경되었습니다.")
          .show();
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "닉네임 변경 오류",
              content: apiResponseDTO.message)
          .show();
    }
  }

  Future<bool> verifySMS() async {
    final ApiResponseDTO apiResponseDTO = await _changeRepository.verifySMS(
        phoneNumber: phoneNumber.value.text,
        accessToken: loginService.token.value.accessToken);
    if (apiResponseDTO.success) {
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "인증번호 전송 성공",
              content: "인증번호가 전송되었습니다. 휴대폰을 확인해주세요")
          .show();
      changePhoneNumberToken = apiResponseDTO.data['token'] as String;
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

  Future<void> changePhoneNumber() async {
    final ApiResponseDTO apiResponseDTO =
        await _changeRepository.changePhoneNumber(
      accessToken: loginService.token.value.accessToken,
      token: changePhoneNumberToken,
      code: phoneAuthenticationNumber.value.text,
    );
    if (apiResponseDTO.success) {
      Get.back();
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "휴대폰 번호 변경 성공",
              content: "휴대폰 번호가 변경되었습니다.")
          .show();
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "휴대폰 번호 변경 오류",
              content: apiResponseDTO.message)
          .show();
    }
  }

  Future<void> changePassword() async{
    final ApiResponseDTO apiResponseDTO = await _changeRepository.changePassword(
      accessToken: loginService.token.value.accessToken,
      currentPassword: currentPassword.value.text,
      newPassword: password.value.text,
    );
    if(apiResponseDTO.success){
      await loginService.logout();
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "비밀번호 변경 성공",
              content: "비밀번호가 변경되었습니다.")
          .show();
    }else{
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "비밀번호 변경 오류",
              content: apiResponseDTO.message)
          .show();
    }
  }

}
