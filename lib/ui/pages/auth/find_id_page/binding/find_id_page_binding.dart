import 'package:danvery/ui/pages/auth/find_id_page/controller/find_id_page_controller.dart';
import 'package:get/get.dart';

class FindIdPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindIdPageController>(() => FindIdPageController());
  }
}
