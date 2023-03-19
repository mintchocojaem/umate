import 'package:danvery/ui/pages/auth/register_page/controller/register_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterSuccessScreen extends GetView<RegisterPageController> {
  const RegisterSuccessScreen({super.key});

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
