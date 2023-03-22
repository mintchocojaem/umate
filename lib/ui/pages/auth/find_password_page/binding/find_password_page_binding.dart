import 'package:get/get.dart';

import '../controller/find_password_page_controller.dart';

class FindPasswordPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindPasswordPageController>(() => FindPasswordPageController());
  }
}
