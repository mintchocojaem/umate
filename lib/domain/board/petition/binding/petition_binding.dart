import 'package:get/get.dart';

import '../controller/petition_controller.dart';
import '../repository/petition_repository.dart';

class PetitionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetitionController>(() => PetitionController(petitionRepository: PetitionRepository()));
  }
}
