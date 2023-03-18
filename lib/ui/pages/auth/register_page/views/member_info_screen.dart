
import 'package:danvery/domain/auth/reigster/controller/register_controller.dart';
import 'package:danvery/domain/auth/reigster/model/register_model.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/widgets/login/login_form_button.dart';
import 'package:danvery/ui/widgets/login/login_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/register_page_controller.dart';


class MemberInfoScreen extends GetView<RegisterController> {
  const MemberInfoScreen({super.key});

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
  Widget build(BuildContext context) {
    // TODO: implement build
    final RegisterController registerController =
        Get.find<RegisterController>();
    final RegisterPageController registerPageController =
        Get.find<RegisterPageController>();

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
                      () => Get.find<RegisterController>()
                              .isStudentAuthenticated
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: LoginFormField(
                                    hint:
                                        "${registerController.registerModel.studentId}@dankook.ac.kr",
                                    title: "아이디",
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: LoginFormField(
                                    hint: "비밀번호를 입력하세요",
                                    title: "비밀번호",
                                    validateHint: "비밀번호를 재입력하세요",
                                    validate: true,
                                    isPassword: true,
                                    textController: registerPageController
                                        .passwordController,
                                    validateController: registerPageController
                                        .passwordValidateController,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: LoginFormField(
                                    hint: registerController
                                        .registerModel.studentName,
                                    title: "이름",
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: LoginFormField(
                                    hint: "닉네임을 입력하세요",
                                    title: "닉네임",
                                    readOnly: false,
                                    textController: registerPageController
                                        .nicknameController,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: LoginFormField(
                                    hint:
                                        registerController.registerModel.major,
                                    title: "전공",
                                    readOnly: true,
                                  ),
                                ),
                                //휴대폰 번호 인증 필요
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: LoginFormField(
                                    textController: registerPageController
                                        .phoneNumberController,
                                    validateController: registerPageController
                                        .phoneAuthenticationNumberController,
                                    hint: "- 는 제외하고 입력하세요",
                                    validate: true,
                                    validateHint: "인증번호 6자리를 입력하세요",
                                    title: "휴대폰 번호",
                                    checkButton: true,
                                    checkButtonText: "인증요청",
                                    onCheckButtonPressed: () {
                                      if (isValidPhoneNumberFormat(
                                              registerPageController
                                                  .phoneNumber) ==
                                          false) {
                                        Get.snackbar(
                                            "휴대폰 번호 오류", "휴대폰 번호를 올바르게 입력해주세요.",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Palette.darkGrey,
                                            colorText: Palette.pureWhite);
                                        return false;
                                      }

                                      registerController
                                          .sendSMSAuth(
                                              registerController
                                                  .registerModel.signupToken,
                                              registerPageController
                                                  .phoneNumber)
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
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LoginFormButton(
                text: "가입하기",
                onPressed: () async {
                  if (registerPageController.nickname.length < 2 ||
                      isValidNicknameFormat(registerPageController.nickname) ==
                          false) {
                    Get.snackbar("닉네임 오류", "닉네임은 3~8자리의 한글, 영문, 숫자, _, 공백만 사용할 수 있습니다.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Palette.darkGrey,
                        colorText: Palette.pureWhite);
                    return;
                  }

                  if( isValidPasswordFormat(registerPageController.password) == false){
                    Get.snackbar("비밀번호 오류", "비밀번호는 영문, 숫자를 포함한 8~16자리만 사용할 수 있습니다.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Palette.darkGrey,
                        colorText: Palette.pureWhite);
                    return;
                  }

                  if (registerPageController.passwordValidate !=
                      registerPageController.password) {
                    Get.snackbar("비밀번호 오류", "비밀번호가 일치하지 않습니다.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Palette.darkGrey,
                        colorText: Palette.pureWhite);
                    return;
                  }

                  if (!await registerController.verifySMSAuth(
                      registerController.registerModel.signupToken,
                      registerPageController.phoneAuthenticationNumber)) {
                    Get.snackbar("인증번호 오류", "인증번호가 일치하지 않습니다",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Palette.darkGrey,
                        colorText: Palette.pureWhite);
                    return;
                  }

                  final RegisterModel registerModel =
                      registerController.registerModel;
                  registerModel.nickname =
                      registerPageController.nicknameController.text;
                  registerModel.password =
                      registerPageController.passwordController.text;

                  /*
                  registerController.register(registerModel).then((value) {
                    if (value) {
                      registerPageController.currentStep = 3;
                    } else {
                      Get.snackbar("회원가입 실패", "회원가입에 실패했습니다. 다시 시도해주세요.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Palette.darkGrey,
                          colorText: Palette.pureWhite);
                    }
                  });

                   */
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
