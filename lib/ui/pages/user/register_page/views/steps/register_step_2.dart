import 'package:danvery/core/regex/regex.dart';
import 'package:danvery/ui/pages/user/register_page/controller/register_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterStep2 extends GetView<RegisterPageController> {
  const RegisterStep2({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  children: [
                    Obx(
                      () => controller.isStudentAuthenticated.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    hint:
                                        "${controller.registerInfo.value.studentId}@dankook.ac.kr",
                                    title: "아이디",
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    hint: controller
                                        .registerInfo.value.studentName,
                                    title: "이름",
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    hint: controller.registerInfo.value.major,
                                    title: "전공",
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    maxLength: 12,
                                    hint: "닉네임을 입력하세요",
                                    title: "닉네임",
                                    readOnly: false,
                                    helperText:
                                        "3~12자, 영문, 한글, 숫자, 특수문자(_), 공백 포함",
                                    onTextChanged: (value) {
                                      controller.nicknameController
                                          .update((val) {
                                        if (val != null) val.text = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    maxLength: 24,
                                    hint: "비밀번호를 입력하세요",
                                    title: "비밀번호",
                                    validateHint: "비밀번호를 재입력하세요",
                                    validateHelperText:
                                        "8~24자, 하나 이상의 영문자와 숫자 포함",
                                    validate: true,
                                    isPassword: true,
                                    onTextChanged: (value) {
                                      controller.passwordController
                                          .update((val) {
                                        if (val != null) val.text = value;
                                      });
                                    },
                                    onValidateChanged: (value) {
                                      controller.passwordValidateController
                                          .update((val) {
                                        if (val != null) val.text = value;
                                      });
                                    },
                                  ),
                                ),
                                //휴대폰 번호 인증 필요
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    maxLength: 11,
                                    onTextChanged: (value) {
                                      controller.phoneNumberController
                                          .update((val) {
                                        if (val != null) val.text = value;
                                      });
                                    },
                                    onValidateChanged: (value) {
                                      controller
                                          .phoneAuthenticationNumberController
                                          .update((val) {
                                        if (val != null) val.text = value;
                                      });
                                    },
                                    hint: "휴대폰 번호를 입력하세요",
                                    validate: true,
                                    validateHint: "인증번호 6자리를 입력하세요",
                                    title: "휴대폰 번호",
                                    checkButton: true,
                                    isSMS: true,
                                    checkButtonText: "인증요청",
                                    onCheckButtonPressed: () async {
                                      if (!phoneNumberCheckRegExp.hasMatch(
                                          controller.phoneNumberController.value
                                              .text)) {
                                        GetXSnackBar(
                                          type:
                                              GetXSnackBarType.phoneNumberError,
                                        ).show();
                                        return false;
                                      }
                                      return controller
                                          .sendSMSAuth(
                                              controller.registerInfo.value
                                                  .signupToken,
                                              controller.phoneNumberController
                                                  .value.text)
                                          .then((value) {
                                        return value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 400,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Obx(
              () => ModernFormButton(
                isEnabled: controller
                        .passwordController.value.text.isNotEmpty &&
                    controller
                        .passwordValidateController.value.text.isNotEmpty &&
                    controller.phoneNumberController.value.text.isNotEmpty &&
                    controller.phoneAuthenticationNumberController.value.text
                        .isNotEmpty &&
                    controller.nicknameController.value.text.isNotEmpty,
                text: "가입하기",
                onPressed: () async {
                  if (controller.nicknameController.value.text.length < 2 ||
                      !nicknameCheckRegExp
                          .hasMatch(controller.nicknameController.value.text)) {
                    GetXSnackBar(
                      type: GetXSnackBarType.nickNameError,
                    ).show();
                    return;
                  }

                  if (!passwordCheckRegExp
                      .hasMatch(controller.passwordController.value.text)) {
                    GetXSnackBar(
                      type: GetXSnackBarType.passwordInputError,
                    ).show();
                    return;
                  }

                  if (controller.passwordValidateController.value !=
                      controller.passwordController.value) {
                    GetXSnackBar(
                      type: GetXSnackBarType.passwordConfirmError,
                    ).show();
                    return;
                  }

                  if (!await controller.verifySMSAuth(
                      controller.registerInfo.value.signupToken,
                      controller
                          .phoneAuthenticationNumberController.value.text)) {
                    return;
                  }

                  controller.registerInfo.value.nickname =
                      controller.nicknameController.value.text;
                  controller.registerInfo.value.nickname =
                      controller.passwordController.value.text;

                  await controller.register();
                  if (controller.isRegistered.value) {
                    controller.currentStep.value = 3;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
