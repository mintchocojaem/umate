import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/repository/petition_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:get/get.dart';

class PetitionPostPageController extends GetxController {
  final PetitionPostRepository _petitionPostRepository =
      PetitionPostRepository();

  final LoginService _loginService = Get.find<LoginService>();

  late Rx<PetitionPostModel> petitionPost;

  final RxBool isLoadedPetitionPost = false.obs;

  final int id = Get.arguments;

  @override
  void onInit() {
    getPetitionPost();
    super.onInit();
  }

  Future<void> getPetitionPost() async {
    final ApiResponseDTO apiResponseDTO =
        await _petitionPostRepository.getPetitionPost(
            token: _loginService.loginInfo.value.accessToken, id: id);
    if (apiResponseDTO.success) {
      final PetitionPostModel petitionPostModel =
          apiResponseDTO.data as PetitionPostModel;
      petitionPost = petitionPostModel.obs;
      isLoadedPetitionPost.value = true;
    }
  }

  Future<void> agreePetition() async {
    final ApiResponseDTO apiResponseDTO =
        await _petitionPostRepository.agreePetitionPost(
            token: _loginService.loginInfo.value.accessToken, id: id);
    if (apiResponseDTO.success) {
      petitionPost.value.agreeCount += 1;
    }else{
      GetXSnackBar(
        title: '청원 게시글 동의 오류',
        content: apiResponseDTO.message,
        type: GetXSnackBarType.customError,
      ).show();
    }
  }

}
