import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:get/get.dart';

import '../controller/post_controller.dart';
import '../provider/post_provider.dart';
import '../repository/post_repository.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController(postRepository: PostRepository(postProvider: PostProvider(dio: DioInterceptor().dio))));
  }
}
