
import 'package:danvery/domain/auth/reigster/controller/register_controller.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/pages/auth/register_page/controller/register_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/login/step_guide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'member_info_screen.dart';
import 'register_success_screen.dart';
import 'student_auth_screen.dart';



class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    List<Widget> pages = [
      StudentAuthScreen(),
      MemberInfoScreen(),
      RegisterSuccessScreen()
    ];

    List<String> stepTitle = ["학생인증", "회원 정보 입력", "가입이 \n완료되었습니다"];

    return Scaffold(
        appBar: TransparentAppBar(
          isDarkMode: Get.isDarkMode,
          title: "회원가입",
          automaticallyImplyLeading: true,
          onPressedLeading: () => Get.back(),
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: StepGuide(
                    stepLength: 3,
                    currentStep:
                        Get.find<RegisterPageController>().currentStep),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  stepTitle[Get.find<RegisterPageController>().currentStep - 1],
                  style: bigTitleStyle.copyWith(
                      color: Palette.blue, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Obx(
                  () => pages[Get.find<RegisterPageController>().currentStep -
                      1], // TODO: Obx로 감싸야 하는지 확인
                ),
              ),
            ],
          ),
        ));
  }
}
