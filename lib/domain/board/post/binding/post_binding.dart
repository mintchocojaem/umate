import 'package:get/get.dart';

import '../controller/post_controller.dart';
import '../repository/post_repository.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController(postRepository: PostRepository()));
  }
}
