import 'package:danvery/ui/pages/main/board/iamge_show_page/controller/image_show_page_controller.dart';
import 'package:get/get.dart';

class ImageShowPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageShowPageController());
  }
}
