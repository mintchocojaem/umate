import 'package:danvery/domain/board/petition/provider/petition_provider.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:get/get.dart';

import '../controller/petition_controller.dart';
import '../repository/petition_repository.dart';

class PetitionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetitionController>(() => PetitionController(
        petitionRepository: PetitionRepository(
            petitionProvider: PetitionProvider(dio: DioInterceptor().dio))));
  }
}
