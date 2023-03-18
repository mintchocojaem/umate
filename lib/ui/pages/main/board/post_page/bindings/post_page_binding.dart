import 'package:get/get.dart';

import '../controllers/post_page_controller.dart';

class PostPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostPageController>(() => PostPageController());
  }
}
