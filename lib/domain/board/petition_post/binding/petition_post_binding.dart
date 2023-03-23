import 'package:danvery/domain/board/petition_post/provider/petition_post_provider.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:get/get.dart';

import '../controller/petition_post_controller.dart';
import '../repository/petition_post_repository.dart';

class PetitionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetitionController>(() => PetitionController(
        petitionRepository: PetitionPostRepository(
            petitionPostProvider: PetitionPostProvider(dio: DioInterceptor().dio))));
  }
}
