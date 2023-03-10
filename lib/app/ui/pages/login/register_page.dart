import 'package:danvery/app/controller/register_controller.dart';
import 'package:danvery/app/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../widgets/login/login_form_button.dart';
import '../../widgets/login/login_form_field.dart';

class RegisterPage extends GetView<RegisterController>{
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TransparentAppBar(
        title: '회원가입',
        automaticallyImplyLeading: true,
        onPressedLeading: () => Get.back(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: LoginFormField(
                              hint: '32XXXXXX' "@dankook.ac.kr",
                              title: "아이디",
                              readOnly: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: LoginFormField(
                              hint: "홍길동",
                              title: "이름",
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
                              hint: "전공을 선택하세요",
                              title: "전공",
                              dropdown: true,
                              dropdownData: ["경영학과","소프트웨어학과","국문어학과"],
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
                                checkButtonText: "인증요청"
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: LoginFormButton(text: "가입하기",
                    onPressed : (){
                      Get.toNamed(Routes.login);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
