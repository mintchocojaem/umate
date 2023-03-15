import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class SplashScreenPageController extends GetxController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  onInit() async{
    await animationInit().whenComplete(() => Get.offAndToNamed(Routes.login));
    super.onInit();
  }

  Future<void> animationInit() async{
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)
            .obs
            .value;
    animation.addListener(() => update());
    await animationController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
  }

}
