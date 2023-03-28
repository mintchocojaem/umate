import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/repository/petition_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:get/get.dart';

class PetitionPostPageController extends GetxController {

  final PetitionPostRepository _petitionPostRepository = PetitionPostRepository();

  final LoginService _loginService = Get.find<LoginService>();

  final Rx<PetitionPostModel> petitionPostModel = PetitionPostModel().obs;

  final RxBool isLoadedPetitionPost = false.obs;

  @override
  void onInit() {
    final int id = Get.arguments;
    getPetitionPost(id);
    super.onInit();
  }

  Future<void> getPetitionPost(int id) async {
    _petitionPostRepository
        .getPetitionPost(token: _loginService.loginModel.accessToken,id: id)
        .then((value) {
      if (value != null) {
        petitionPostModel.value = value;
        isLoadedPetitionPost.value = true;
      }
    });
  }

}
