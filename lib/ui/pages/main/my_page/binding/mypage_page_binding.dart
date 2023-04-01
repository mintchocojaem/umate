import 'package:get/get.dart';

import '../controller/mypage_page_controller.dart';

class MyPagePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> MyPagePageController(), fenix: true);
  }
}
