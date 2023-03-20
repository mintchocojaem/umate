import 'package:danvery/ui/pages/auth/register_page/controller/register_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/modern/modern_step_guide.dart';

class RegisterPage extends GetView<RegisterPageController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
                child: ModernStepGuide(
                    stepLength: 3,
                    currentStep:
                        Get.find<RegisterPageController>().currentStep),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  controller.stepTitle[
                      Get.find<RegisterPageController>().currentStep - 1],
                  style: bigTitleStyle.copyWith(
                      color: Palette.blue, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Obx(
                  () => controller.pages[
                      Get.find<RegisterPageController>().currentStep -
                          1
                  ], // TODO: Obx로 감싸야 하는지 확인
                ),
              ),
            ],
          ),
        ));
  }
}