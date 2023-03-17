import 'package:danvery/app/controller/page/splash_screen_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenPageController>(
        builder: (controller) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/icons/splash/app_icon.png',
                    width: 128,
                    height: 128,
                    opacity: controller.animation,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
