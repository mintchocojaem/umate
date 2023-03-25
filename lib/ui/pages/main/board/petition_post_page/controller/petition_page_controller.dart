import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/repository/petition_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:get/get.dart';

class PetitionPostPageController extends GetxController {

  final PetitionPostRepository _petitionPostRepository = PetitionPostRepository();

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
    _petitionPostRepository
        .getPetitionPost(loginService.loginModel.accessToken, id)
        .then((value) {
      if (value != null) {
        _petitionPostModel.value = value;
        _isLoadedPetitionPost.value = true;
      }
    });
    super.onInit();
  }
}
