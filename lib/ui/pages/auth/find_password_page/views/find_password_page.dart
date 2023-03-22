import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/theme/app_text_theme.dart';
import '../../../../../utils/theme/palette.dart';
import '../../../../widgets/app_bar/transparent_app_bar.dart';
import '../../../../widgets/modern/modern_step_guide.dart';
import '../controller/find_password_page_controller.dart';

class FindPasswordPage extends GetView<FindPasswordPageController> {
  const FindPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "비밀번호 찾기",
        automaticallyImplyLeading: true,
        onPressedLeading: () => Get.back(),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ModernStepGuide(
                  stepLength: 3,
                  currentStep:
                      Get.find<FindPasswordPageController>().currentStep),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                controller.stepTitle[
                    Get.find<FindPasswordPageController>().currentStep - 1],
                style: bigTitleStyle.copyWith(
                    color: Palette.blue, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.pages[
                    Get.find<FindPasswordPageController>().currentStep - 1],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
