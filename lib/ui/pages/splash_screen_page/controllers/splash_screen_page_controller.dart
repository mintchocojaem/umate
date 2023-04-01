import 'package:danvery/domain/user/login/model/login_model.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../routes/app_routes.dart';


class SplashScreenPageController extends GetxController with GetSingleTickerProviderStateMixin{

  //final LoginService loginService = Get.find<LoginService>();

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  onInit() async{
    //final GetStorage box = GetStorage();
    await animationInit().whenComplete(() {
      /*final LoginModel? loginModel = box.read('loginModel');
      if(loginModel != null){
        loginService.login(loginModel.studentId, loginModel.);
        Get.offNamed(Routes.home);
      }else{
        Get.offNamed(Routes.login);
      }

       */
      Get.offNamed(Routes.login);
    });
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
