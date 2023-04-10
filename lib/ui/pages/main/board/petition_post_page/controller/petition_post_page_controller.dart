import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_statistic_model.dart';
import 'package:danvery/domain/board/post/petition_post/repository/petition_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:get/get.dart';

class PetitionPostPageController extends GetxController {
  final PetitionPostRepository _petitionPostRepository =
  PetitionPostRepository();

  final LoginService _loginService = Get.find<LoginService>();

  final BoardPageController boardPageController = Get.find<BoardPageController>();

  late Rx<PetitionPostModel> petitionPost;

  final RxBool isLoadedPetitionPost = false.obs;

  final int id = Get.arguments;

  final RxBool isLoadedImageList = false.obs;

  @override
  void onInit() {
    getPetitionPost();
    super.onInit();
  }

  Future<void> getPetitionPost() async {
    final ApiResponseDTO apiResponseDTO =
    await _petitionPostRepository.getPetitionPost(
        token: _loginService.token.value.accessToken, id: id);
    if (apiResponseDTO.success) {
      final PetitionPostModel petitionPostModel =
      apiResponseDTO.data as PetitionPostModel;
      petitionPost = petitionPostModel.obs;
      await getImageList();
      isLoadedPetitionPost.value = true;
    }
  }

  Future<void> deletePetitionPost(int id) async {
    final ApiResponseDTO apiResponseDTO =
    await _petitionPostRepository.deletePetitionPost(
        token: _loginService.token.value.accessToken, id: id);
    if (apiResponseDTO.success) {
      await boardPageController.getFirstPetitionPostBoard();
      Get.back();
    } else {
      GetXSnackBar(
          type: GetXSnackBarType.customError,
          content: apiResponseDTO.message,
          title: "게시글 삭제 오류").show();
    }
  }

  Future<void> agreePetition() async {
    final ApiResponseDTO apiResponseDTO =
    await _petitionPostRepository.agreePetitionPost(
        token: _loginService.token.value.accessToken, id: id);
    if (apiResponseDTO.success) {
      petitionPost.update((val) {
        val!.agreeCount += 1;
        final userDepartment = _loginService.userInfo.value.department;
        if (val.statisticList.where((element) => element.department == userDepartment).isEmpty) {
          val.statisticList.add(PetitionStatisticModel(agreeCount: 1, department: userDepartment));
        }else{
          val.statisticList.firstWhere((element) => element.department == userDepartment).agreeCount += 1;
        }
      });
    } else {
      GetXSnackBar(
        title: '청원 게시글 동의 오류',
        content: apiResponseDTO.message,
        type: GetXSnackBarType.customError,
      ).show();
    }
  }

  void saveAndGetBack() {
    if (isLoadedPetitionPost.value) {
      petitionPost.value.agreeCount = petitionPost.value.agreeCount;
      Get.back(result: petitionPost.value);
    } else {
      Get.back();
    }
  }

  Future<void> getImageList() async {
    for (FileModel j in petitionPost.value.files) {
      j.url = (await fileFromImageUrl(j.url, j.originalName ?? "image$j")).path;
    }
    isLoadedImageList.value = true;
  }

}
