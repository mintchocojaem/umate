import 'package:danvery/ui/pages/main/board/general_post_write_page/controller/general_post_write_page_controller.dart';
import 'package:get/get.dart';

class GeneralPostWritePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralPostWritePageController>(() => GeneralPostWritePageController());
  }
}
