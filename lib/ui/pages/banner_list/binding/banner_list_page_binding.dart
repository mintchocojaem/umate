import 'package:danvery/ui/pages/banner_list/controller/banner_list_page_controller.dart';
import 'package:get/get.dart';

class BannerListPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BannerListPageController());
  }

}
