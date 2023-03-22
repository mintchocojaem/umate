import 'package:danvery/ui/pages/auth/register_page/controller/register_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterStep3 extends GetView<RegisterPageController> {
  const RegisterStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ModernFormButton(
        text: "로그인하러 가기",
        onPressed: () {
          Get.back();
          Get.delete<RegisterPageController>();
        },
      ),
    );
  }
}
