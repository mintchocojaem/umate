import 'package:danvery/core/regex/regex.dart';
import 'package:danvery/domain/user/reigster/model/register_model.dart';
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
                                        "${controller.registerModel.value.studentId}@dankook.ac.kr",
                                    title: "아이디",
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    hint: "비밀번호를 입력하세요",
                                    title: "비밀번호",
                                    validateHint: "비밀번호를 재입력하세요",
                                    validate: true,
                                    isPassword: true,
                                    onTextChanged: (value) {
                                      controller.password.value = value;
                                    },
                                    onValidateChanged: (value) {
                                      controller.passwordValidate.value = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    hint: controller
                                        .registerModel.value.studentName,
                                    title: "이름",
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    hint: "닉네임을 입력하세요",
                                    title: "닉네임",
                                    readOnly: false,
                                    onTextChanged: (value) {
                                      controller.nickname.value = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    hint: controller.registerModel.value.major,
                                    title: "전공",
                                    readOnly: true,
                                  ),
                                ),
                                //휴대폰 번호 인증 필요
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ModernFormField(
                                    onTextChanged: (value) {
                                      controller.phoneNumber.value = value;
                                    },
                                    onValidateChanged: (value) {
                                      controller.phoneAuthenticationNumber
                                          .value = value;
                                    },
                                    hint: "휴대폰 번호를 입력하세요",
                                    validate: true,
                                    validateHint: "인증번호 6자리를 입력하세요",
                                    title: "휴대폰 번호",
                                    checkButton: true,
                                    isSMS: true,
                                    checkButtonText: "인증요청",
                                    onCheckButtonPressed: () {
                                      if (!isValidPhoneNumberFormat(
                                          controller.phoneNumber.value)) {
                                        GetXSnackBar(
                                          type: GetXSnackBarType.phoneNumberError,
                                        ).show();
                                        return false;
                                      }
                                      controller
                                          .sendSMSAuth(
                                              controller.registerModel.value
                                                  .signupToken,
                                              controller.phoneNumber.value)
                                          .then((value) {
                                        if (!value) {
                                          return false;
                                        } else {
                                          return true;
                                        }
                                      });
                                      return false;
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 64,
                              width: 64,
                              child: CircularProgressIndicator(),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Obx(
              () => ModernFormButton(
                isEnabled: controller.password.value.isNotEmpty &&
                    controller.passwordValidate.value.isNotEmpty &&
                    controller.phoneNumber.value.isNotEmpty &&
                    controller.phoneAuthenticationNumber.value.isNotEmpty &&
                    controller.nickname.value.isNotEmpty,
                text: "가입하기",
                onPressed: () async {
                  if (controller.nickname.value.length < 2 ||
                      isValidNicknameFormat(controller.nickname.value) ==
                          false) {
                    GetXSnackBar(
                      type: GetXSnackBarType.nickNameError,
                    ).show();
                    return;
                  }

                  if (isValidPasswordFormat(controller.password.value) ==
                      false) {
                    GetXSnackBar(
                      type: GetXSnackBarType.passwordInputError,
                    ).show();
                    return;
                  }

                  if (controller.passwordValidate.value !=
                      controller.password.value) {
                    GetXSnackBar(
                      type: GetXSnackBarType.passwordConfirmError,
                    ).show();
                    return;
                  }

                  if (!await controller.verifySMSAuth(
                      controller.registerModel.value.signupToken,
                      controller.phoneAuthenticationNumber.value)) {
                    return;
                  }

                  final RegisterModel registerModel =
                      controller.registerModel.value;
                  registerModel.nickname = controller.nickname.value;
                  registerModel.password = controller.password.value;

                  if(await controller.register(registerModel)){
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
