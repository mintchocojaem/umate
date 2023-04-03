import 'package:get/get.dart';

import '../controller/general_post_page_controller.dart';

class GeneralPostPageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<GeneralPostPageController>(()=> GeneralPostPageController(), fenix: true);
  }
}
