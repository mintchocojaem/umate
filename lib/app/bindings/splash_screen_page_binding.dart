import 'package:danvery/app/controller/splash_screen_page_controller.dart';
import 'package:get/get.dart';

class SplashScreenPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenPageController>(() => SplashScreenPageController());

  }
}
