import 'package:danvery/ui/pages/main/board/petition_post_write_page/controller/petition_post_write_page_controller.dart';
import 'package:get/get.dart';

class PetitionPostWritePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetitionPostWritePageController>(() => PetitionPostWritePageController());
  }
}
