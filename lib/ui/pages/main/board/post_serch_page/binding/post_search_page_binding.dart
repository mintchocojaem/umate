import 'package:danvery/ui/pages/main/board/post_serch_page/controller/post_search_page_controller.dart';
import 'package:get/get.dart';

class PostSearchPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostSearchPageController>(
      () => PostSearchPageController(),
    );
  }
}
