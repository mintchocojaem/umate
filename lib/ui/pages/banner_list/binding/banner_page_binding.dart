import 'package:danvery/ui/pages/banner_list/controller/banner_page_controller.dart';
import 'package:get/get.dart';

class BannerPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BannerPageController());
  }

}
