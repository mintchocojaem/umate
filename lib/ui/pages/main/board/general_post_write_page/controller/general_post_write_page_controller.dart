import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
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

  final RxBool isPosting = false.obs;

  Future<void> writeGeneralPost(
      String token, GeneralPostModel generalPostModel) async {
    await _generalPostRepository
        .writeGeneralPost(token: token, postModel: generalPostModel)
        .then((value) {
      if (value.success) {
        boardPageController
            .getFirstGeneralPostBoard()
            .whenComplete(() {
          isPosting.value = false;
          Get.back();
        }
        );
      } else {
        GetXSnackBar(
          title: "글 작성 실패",
          content: value.message,
          type: GetXSnackBarType.customError,
        ).show();
      }
    });
  }
}
