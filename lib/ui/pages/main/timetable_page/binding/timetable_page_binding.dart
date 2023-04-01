import 'package:get/get.dart';

import '../controller/timetable_page_controller.dart';

class TimetablePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimetablePageController>(()=>TimetablePageController(), fenix: true);
  }
}
