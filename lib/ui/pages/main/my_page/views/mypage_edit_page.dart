import 'package:danvery/core/regex/regex.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/main/my_page/controller/mypage_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageEditPage extends GetView<MyPagePageController> {
  const MyPageEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    controller.initEditPage();
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "프로필 수정",
        automaticallyImplyLeading: true,
        onPressedLeading: () => Get.back(),
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/icons/user/profile_icon.png",
                                width: 128,
                                height: 128,
                              ),
                            ),
                            /*
                            Center(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  maximumSize: const Size(100, 28),
                                  minimumSize: const Size(100, 28),
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    bottom: 4,
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "사진 업로드",
                                  style: regularStyle.copyWith(
                                      color: Palette.lightBlue),
                                ),
                              ),
                            ),
                             */
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: ModernFormField(
                                initText: controller.nickname.value.text,
                                hint: "닉네임을 입력하세요",
                                title: "닉네임 변경",
                                readOnly: false,
                                maxLength: 12,
                                helperText: "3~12자, 영문, 한글, 숫자, 특수문자(_), 공백 포함",
                                onTextChanged: (value) {
                                  controller.nickname.update((val) {
                                    if(val != null){
                                      val.text = value;
                                    }
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: ModernFormField(
                                maxLength: 24,
                                hint: "새로운 비밀번호를 입력하세요",
                                title: "비밀번호 변경",
                                validateHint: "새로운 비밀번호를 재입력하세요",
                                validateHelperText: "8~24자, 하나 이상의 영문자와 숫자 포함",
                                currentPasswordHint: "현재 비밀번호를 입력하세요",
                                validate: true,
                                addCurrentPassword: true,
                                onCurrentPasswordTextChanged: (value) {
                                  controller.currentPassword.update((val) {
                                    if(val != null){
                                      val.text = value;
                                    }
                                  });
                                },
                                onTextChanged: (value) {
                                  controller.password.update((val) {
                                    if(val != null){
                                      val.text = value;
                                    }
                                  });
                                },
                                onValidateChanged: (value) {
                                  controller.passwordValidate.update((val) {
                                    if(val != null){
                                      val.text = value;
                                    }
                                  });
                                },
                              ),
                            ),
                            //휴대폰 번호 인증 필요
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: ModernFormField(
                                onTextChanged: (value) {
                                  controller.phoneNumber.update((val) {
                                    if(val != null){
                                      val.text = value;
                                    }
                                  });
                                },
                                onValidateChanged: (value) {
                                  controller.phoneAuthenticationNumber.update((val) {
                                    if(val != null){
                                      val.text = value;
                                    }
                                  });
                                },
                                hint: "휴대폰 번호를 입력하세요",
                                validate: true,
                                validateHint: "인증번호 6자리를 입력하세요",
                                title: "휴대폰 번호 변경",
                                checkButton: true,
                                isSMS: true,
                                checkButtonText: "인증요청",
                                onCheckButtonPressed: () async{
                                  if (!phoneNumberCheckRegExp
                                      .hasMatch(controller.phoneNumber.value.text)) {
                                    GetXSnackBar(
                                      type: GetXSnackBarType.phoneNumberError,
                                    ).show();
                                    return false;
                                  }
                                  return controller.verifySMS().then((value){
                                    return value;
                                  });
                               },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ModernFormButton(
                  isEnabled: (controller.currentPassword.value.text.isNotEmpty &&
                          controller.password.value.text.isNotEmpty &&
                          controller.passwordValidate.value.text.isNotEmpty &&
                          controller.nickname.value.text.isNotEmpty) ||
                      (controller.nickname.value.text.isNotEmpty &&
                          controller.nickname.value.text !=
                              controller.loginService.userInfo.value.nickname) ||
                      (controller.phoneNumber.value.text.isNotEmpty &&
                          controller.phoneAuthenticationNumber.value.text.isNotEmpty &&
                          controller.nickname.value.text.isNotEmpty),
                  text: "저장",
                  onPressed: () async {
                    if (controller.currentPassword.value.text.isNotEmpty &&
                        controller.password.value.text.isNotEmpty &&
                        controller.passwordValidate.value.text.isNotEmpty &&
                        controller.nickname.value.text.isNotEmpty) {
                      if (controller.password.value !=
                          controller.passwordValidate.value) {
                        GetXSnackBar(
                          type: GetXSnackBarType.passwordConfirmError,
                        ).show();
                        return;
                      }
                      if (!passwordCheckRegExp
                          .hasMatch(controller.password.value.text)) {
                        GetXSnackBar(
                          type: GetXSnackBarType.passwordInputError,
                        ).show();
                        return;
                      }
                      await controller.changePassword();
                    }
                    if (controller.nickname.value.text.isNotEmpty &&
                        controller.nickname.value.text !=
                            controller.loginService.userInfo.value.nickname) {
                      await controller.changeNickname();
                    }

                    if (controller.phoneNumber.value.text.isNotEmpty &&
                        controller.phoneAuthenticationNumber.value.text.isNotEmpty &&
                        controller.nickname.value.text.isNotEmpty) {
                      await controller.changePhoneNumber();
                    }

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
