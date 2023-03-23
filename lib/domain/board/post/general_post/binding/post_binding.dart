import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:get/get.dart';

import '../controller/general_post_controller.dart';
import '../provider/general_post_provider.dart';
import '../repository/general_post_repository.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralPostController>(() => GeneralPostController(generalPostRepository: GeneralPostRepository(generalPostProvider: GeneralPostProvider(dio: DioInterceptor().dio))));
  }
}
