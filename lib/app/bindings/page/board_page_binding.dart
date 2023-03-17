import 'package:get/get.dart';
import '../../controller/page/board_page_controller.dart';

class BoardPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardPageController>(() => BoardPageController());
  }
}
