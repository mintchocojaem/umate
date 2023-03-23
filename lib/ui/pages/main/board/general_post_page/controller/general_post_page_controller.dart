import 'package:get/get.dart';

import '../../../../../../domain/auth/login/service/login_service.dart';
import '../../../../../../domain/board/general_post/controller/general_post_controller.dart';
import '../../../../../../domain/board/general_post/model/general_post_model.dart';

class GeneralPostPageController extends GetxController {

  final GeneralPostController generalPostController = Get.find<GeneralPostController>();
  final LoginService loginService = Get.find<LoginService>();

  final Rx<GeneralPostModel> _generalPostModel = GeneralPostModel().obs;

  set generalPostModel(value) => _generalPostModel.value = value;

  GeneralPostModel get generalPostModel => _generalPostModel.value;

  final RxBool _isLoadedGeneralPost = false.obs;

  set isLoadedGeneralPost(value) => _isLoadedGeneralPost.value = value;

  bool get isLoadedGeneralPost => _isLoadedGeneralPost.value;

  @override
  void onInit() {
    final int id = Get.arguments;
    generalPostController
        .getGeneralPost(loginService.loginModel.accessToken, id)
        .then((value) {
      if (value != null) {
        _generalPostModel.value = value;
        _isLoadedGeneralPost.value = true;
      }
    });
    super.onInit();
  }
}
