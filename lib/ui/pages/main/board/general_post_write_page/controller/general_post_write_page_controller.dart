import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_wirte_model.dart';
import 'package:danvery/domain/board/post/general_post/repository/general_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/service/permission/permission_service.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GeneralPostWritePageController extends GetxController {
  final PermissionService permissionService = Get.find<PermissionService>();

  final GeneralPostRepository _generalPostRepository = GeneralPostRepository();

  final LoginService loginService = Get.find<LoginService>();

  final BoardPageController boardPageController =
      Get.find<BoardPageController>();

  final Rx<TextEditingController> titleController = TextEditingController().obs;

  final Rx<TextEditingController> contentController =
      TextEditingController().obs;

  final RxList<XFile> imageList = <XFile>[].obs;

  final RxBool isPosting = false.obs;

  @override
  void onInit() {
    titleController.value.addListener(() {
      titleController.refresh();
    });
    contentController.value.addListener(() {
      contentController.refresh();
    });
    super.onInit();
  }

  Future<void> writeGeneralPost(
      GeneralPostWriteModel generalPostWriteModel) async {
    isPosting.value = true;

    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.writeGeneralPost(
            token: loginService.token.value.accessToken,
            generalPostWriteModel: generalPostWriteModel);
    if (apiResponseDTO.success) {
      await boardPageController.getGeneralPostBoardWithRefresh(true);
      Get.back();
    } else {
      GetXSnackBar(
        type: GetXSnackBarType.customError,
        title: "게시글 작성 실패",
        content: apiResponseDTO.message,
      ).show();
    }
    isPosting.value = false;
  }
}
