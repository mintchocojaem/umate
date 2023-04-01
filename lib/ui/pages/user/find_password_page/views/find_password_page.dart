import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/app_text_theme.dart';
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
                  stepLength: 4,
                  currentStep:
                      controller.currentStep.value),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                controller.stepTitle[
                    controller.currentStep.value - 1],
                style: bigTitleStyle.copyWith(
                    color: Palette.blue, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: controller.pages[controller.currentStep.value - 1],
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: animation.drive(
                        Tween(begin: const Offset(1, 0), end: Offset.zero)
                            .chain(CurveTween(curve: Curves.easeInOut))),
                    child: child,
                  );
                },
                layoutBuilder: (currentChild, previousChildren) =>
                currentChild!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
