import 'package:get/get.dart';

import '../controller/petition_page_controller.dart';

class PetitionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PetitionPageController());
  }
}
