import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_screen_page_controller.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenPageController>(
        builder: (controller) {
          return Center(
            child: Image.asset(
              'assets/icons/splash/app_icon.png',
              width: 128,
              height: 128,
              opacity: controller.animation,
            ),
          );
        },
      ),
    );
  }
}
