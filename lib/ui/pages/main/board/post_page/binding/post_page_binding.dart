import 'package:get/get.dart';

import '../controller/post_page_controller.dart';

class PostPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostPageController>(() => PostPageController());
  }
}
