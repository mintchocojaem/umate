import 'package:danvery/app/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../controller/register_page_controller.dart';
import '../../widgets/login/login_form_button.dart';
import '../../widgets/login/login_form_field.dart';

class MemberInfoScreen extends GetView<RegisterController> {
  const MemberInfoScreen({super.key});

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
                      () => Get.find<RegisterController>().isAuthenticated
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8),
                                  child: LoginFormField(
                                    hint:
                                        "${Get.find<RegisterController>().registerModel.studentId}@dankook.ac.kr",
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
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: LoginFormField(
                                    hint: Get.find<RegisterController>()
                                        .registerModel
                                        .studentName,
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
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: LoginFormField(
                                    hint: Get.find<RegisterController>()
                                        .registerModel
                                        .major,
                                    title: "전공",
                                    readOnly: true,
                                  ),
                                ),
                                //휴대폰 번호 인증 필요
                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: LoginFormField(
                                      hint: "- 는 제외하고 입력하세요",
                                      validate: true,
                                      validateHint: "인증번호 6자리를 입력하세요",
                                      title: "휴대폰 번호",
                                      checkButton: true,
                                      checkButtonText: "인증요청"),
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LoginFormButton(
                text: "가입하기",
                onPressed: () {
                  Get.find<RegisterPageController>().currentStep = 3;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
