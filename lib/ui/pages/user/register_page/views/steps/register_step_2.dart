import 'package:danvery/domain/user/reigster/model/register_model.dart';
import 'package:danvery/ui/pages/user/register_page/controller/register_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/regex/regex.dart';

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
                                    textController:
                                        controller.passwordController,
                                    validateController:
                                        controller.passwordValidateController,
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
                                    textController:
                                        controller.nicknameController,
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
                                    textController:
                                        controller.phoneNumberController,
                                    validateController: controller
                                        .phoneAuthenticationNumberController,
                                    hint: "휴대폰 번호를 입력하세요",
                                    validate: true,
                                    validateHint: "인증번호 6자리를 입력하세요",
                                    title: "휴대폰 번호",
                                    checkButton: true,
                                    isSMS: true,
                                    checkButtonText: "인증요청",
                                    onCheckButtonPressed: () {
                                      if (isValidPhoneNumberFormat(
                                              controller.phoneNumber.value) ==
                                          false) {
                                        Get.snackbar(
                                            "휴대폰 번호 오류", "휴대폰 번호를 올바르게 입력해주세요.",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Palette.darkGrey,
                                            colorText: Palette.pureWhite);
                                        return false;
                                      }

                                      controller
                                          .sendSMSAuth(
                                              controller.registerModel.value
                                                  .signupToken,
                                              controller.phoneNumber.value)
                                          .then((value) {
                                        if (!value) {
                                          Get.snackbar("인증번호 전송 실패",
                                              "인증번호 전송에 실패했습니다. 다시 시도해주세요.",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Palette.darkGrey,
                                              colorText: Palette.pureWhite);
                                        }
                                      });
                                      return true;
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
                isEnabled: controller.password.isNotEmpty &&
                    controller.passwordValidate.isNotEmpty &&
                    controller.phoneNumber.isNotEmpty &&
                    controller.phoneAuthenticationNumber.isNotEmpty &&
                    controller.nickname.isNotEmpty,
                text: "가입하기",
                onPressed: () async {
                  if (controller.nickname.value.length < 2 ||
                      isValidNicknameFormat(controller.nickname.value) ==
                          false) {
                    Get.snackbar(
                        "닉네임 오류", "닉네임은 3~8자리의 한글, 영문, 숫자, _, 공백만 사용할 수 있습니다.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Palette.darkGrey,
                        colorText: Palette.pureWhite);
                    return;
                  }

                  if (isValidPasswordFormat(controller.password.value) ==
                      false) {
                    Get.snackbar(
                        "비밀번호 오류", "비밀번호는 숫자와 영문을 포함해야하며 8 ~ 16자 사이어야 합니다.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Palette.darkGrey,
                        colorText: Palette.pureWhite);
                    return;
                  }

                  if (controller.passwordValidate != controller.password) {
                    Get.snackbar("비밀번호 오류", "비밀번호가 일치하지 않습니다.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Palette.darkGrey,
                        colorText: Palette.pureWhite);
                    return;
                  }

                  if (!await controller.verifySMSAuth(
                      controller.registerModel.value.signupToken,
                      controller.phoneAuthenticationNumber.value)) {
                    Get.snackbar("인증번호 오류", "인증번호가 일치하지 않습니다",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Palette.darkGrey,
                        colorText: Palette.pureWhite);
                    return;
                  }

                  final RegisterModel registerModel =
                      controller.registerModel.value;
                  registerModel.nickname = controller.nicknameController.text;
                  registerModel.password = controller.passwordController.text;
                  /*
                registerController.register(registerModel).then((value) {
                  if (value) {
                    controller.currentStep = 3;
                  } else {
                    Get.snackbar("회원가입 실패", "회원가입에 실패했습니다. 다시 시도해주세요.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Palette.darkGrey,
                        colorText: Palette.pureWhite);
                  }
                });

                 */
                  controller.currentStep.value = 3;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
