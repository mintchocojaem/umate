import 'package:danvery/app/controller/register_controller.dart';
import 'package:danvery/app/controller/register_page_controller.dart';
import 'package:danvery/app/ui/pages/login/authentication_screen.dart';
import 'package:danvery/app/ui/pages/login/member_info_screen.dart';
import 'package:danvery/app/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/app/ui/widgets/login/step_guide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_text_theme.dart';
import '../../theme/palette.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    List<String> stepTitle = ["학생인증","회원 정보 입력"];

    return Scaffold(
        appBar: TransparentAppBar(
          title: "회원가입",
          automaticallyImplyLeading: true,
          onPressedLeading: () => Get.back(),
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: StepGuide(
                    stepLength: 3,
                    currentStep: Get.find<RegisterPageController>().currentStep),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  stepTitle[Get.find<RegisterPageController>().currentStep -1],
                  style: bigTitleStyle.copyWith(
                      color: Palette.blue,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: Get.find<RegisterPageController>().currentStep -1,
                  children: const [
                    AuthenticationScreen(),
                    MemberInfoScreen(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
