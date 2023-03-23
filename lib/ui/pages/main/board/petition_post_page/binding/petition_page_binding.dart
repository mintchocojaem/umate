import 'package:get/get.dart';

import '../controller/petition_page_controller.dart';

class PetitionPostPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PetitionPostPageController());
  }
}
