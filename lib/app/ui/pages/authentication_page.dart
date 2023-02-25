import 'package:danvery/app/controller/authentication_controller.dart';
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/widgets/login_form_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../widgets/login_form_field.dart';

class AuthenticationPage extends GetView<AuthenticationController> {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: transparent,
        title: Text(
          "학생 인증",
          style: titleStyle.copyWith(color: black),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Column(
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/icons/school_mark/dankook_emblem.png",
                    width: 200,
                    height: 200,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: LoginFormField(
                      hint: '32XXXXXX',
                      title: "학번",
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: LoginFormField(
                      hint: "비밀번호를 입력하세요",
                      title: "비밀번호",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              LoginFormButton(
                  text: "인증",
                  onPressed: () async {
                    await AuthenticationController.to
                        .authenticate()
                        .whenComplete(() => Get.toNamed(Routes.register));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
