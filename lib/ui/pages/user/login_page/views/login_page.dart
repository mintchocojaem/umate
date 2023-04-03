
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/user/login_page/controller/login_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/modern/modern_form_field.dart';


class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            MainAppBar(
              isWhite: false,
              isDarkMode: Get.isDarkMode,
              backGroundColor: Palette.transparent,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top:  16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ModernFormField(
                          onTextChanged: (value) {
                            controller.id.value = value;
                          },
                          hint: 'ID(학번)을 입력하세요',
                          title: "아이디",
                          titleColor: Palette.blue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: ModernFormField(
                          onTextChanged: (value) {
                            controller.password.value = value;
                          },
                          hint: "비밀번호를 입력하세요",
                          title: "비밀번호",
                          isPassword: true,
                          titleColor: Palette.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ModernFormButton(
                      text: "로그인",
                      onPressed: () async{
                        await controller.loginService
                            .login(controller.id.value,
                            controller.password.value) //new: '12345678', '121212'
                            .then((value) {
                          if (controller.loginService.isLogin.value) {
                            Get.offAndToNamed(Routes.main);
                          }
                        });
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.toNamed(Routes.findPassword);
                        },
                        child: Text(
                          "비밀번호 찾기",
                          style: tinyStyle.copyWith(color: Palette.darkGrey),
                        ),
                      ),
                      const Text(
                        "|",
                        style: tinyStyle,
                      ),
                      TextButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Get.toNamed(Routes.findId);
                          },
                          child: Text("아이디 찾기",
                              style: tinyStyle.copyWith(color: Palette.darkGrey))),
                      const Text(
                        "|",
                        style: tinyStyle,
                      ),
                      TextButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Get.toNamed(Routes.register);
                          },
                          child: Text(
                            "회원가입",
                            style: tinyStyle.copyWith(color: Palette.blue),
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
