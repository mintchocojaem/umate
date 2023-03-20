import 'package:danvery/domain/board/petition/controller/petition_controller.dart';
import 'package:danvery/domain/board/petition/model/petition_model.dart';
import 'package:get/get.dart';

import '../../../../../../domain/auth/login/service/login_service.dart';


class PetitionPageController extends GetxController {

  final PetitionController petitionController = Get.find<PetitionController>();
  final LoginService loginService = Get.find<LoginService>();

  final Rx<PetitionModel> _petitionModel = PetitionModel().obs;

  set petitionModel(value) => _petitionModel.value = value;

  PetitionModel get petitionModel => _petitionModel.value;

  final RxBool _isLoadedPetition = false.obs;

  set isLoadedPetition(value) => _isLoadedPetition.value = value;

  bool get isLoadedPetition => _isLoadedPetition.value;

  @override
  void onInit() {
    final int id = Get.arguments;
    petitionController
        .getPetition(loginService.loginModel.accessToken, id)
        .then((value) {
      if (value != null) {
        _petitionModel.value = value;
        _isLoadedPetition.value = true;
      }
    });
    super.onInit();
  }
}
