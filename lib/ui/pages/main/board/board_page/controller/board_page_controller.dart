import 'package:get/get.dart';

import '../../../../../../domain/board/general_post/controller/general_post_controller.dart';
import '../../../../../../domain/board/petition_post/controller/petition_post_controller.dart';

class BoardPageController extends GetxController{

  final RxInt _selectedTap = 0.obs;
  int get selectedTap => _selectedTap.value;
  set selectedTap(index) => _selectedTap.value = index;

  final RxInt _selectedCategory = 0.obs;
  int get selectedCategory => _selectedCategory.value;
  set selectedCategory(index) => _selectedCategory.value = index;

  final GeneralPostController postController = Get.find<GeneralPostController>();
  final PetitionController petitionController = Get.find<PetitionController>();

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

}
