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

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  final RxList<XFile> imageList = <XFile>[].obs;


  Future<void> writeGeneralPost(
      GeneralPostWriteModel generalPostWriteModel) async {

    if(titleController.text.isEmpty){
      GetXSnackBar(
        title: "게시글 등록 오류",
        content: "게시글의 제목을 입력해주세요",
        type: GetXSnackBarType.customError,
      ).show();
      return;
    }

    if(contentController.text.isEmpty){
      GetXSnackBar(
        title: "게시글 등록 오류",
        content: "게시글의 내용을 입력해주세요",
        type: GetXSnackBarType.customError,
      ).show();
      return;
    }

    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.writeGeneralPost(
            token: loginService.token.value.accessToken,
            generalPostWriteModel: generalPostWriteModel);
    if (apiResponseDTO.success) {
      await boardPageController.getFirstGeneralPostBoard();
      Get.back();
    } else {
      GetXSnackBar(
        title: "글 작성 실패",
        content: apiResponseDTO.message,
        type: GetXSnackBarType.customError,
      ).show();
    }

  }
}
