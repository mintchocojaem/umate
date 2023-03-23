import 'package:danvery/domain/board/post/petition_post/controller/petition_post_controller.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:get/get.dart';

import '../../../../../../domain/auth/login/service/login_service.dart';


class PetitionPostPageController extends GetxController {

  final PetitionController petitionPostController = Get.find<PetitionController>();
  final LoginService loginService = Get.find<LoginService>();

  final Rx<PetitionPostModel> _petitionPostModel = PetitionPostModel().obs;

  set petitionPostModel(value) => _petitionPostModel.value = value;

  PetitionPostModel get petitionPostModel => _petitionPostModel.value;

  final RxBool _isLoadedPetitionPost = false.obs;

  set isLoadedPetitionPost(value) => _isLoadedPetitionPost.value = value;

  bool get isLoadedPetitionPost => _isLoadedPetitionPost.value;

  @override
  void onInit() {
    final int id = Get.arguments;
    petitionPostController
        .getPetition(loginService.loginModel.accessToken, id)
        .then((value) {
      if (value != null) {
        _petitionPostModel.value = value;
        _isLoadedPetitionPost.value = true;
      }
    });
    super.onInit();
  }
}
