import 'package:get/get.dart';

import '../../../../../../domain/auth/login/service/login_service.dart';
import '../../../../../../domain/board/post/controller/post_controller.dart';
import '../../../../../../domain/board/post/model/post_model.dart';

class PostPageController extends GetxController {

  final PostController postController = Get.find<PostController>();
  final LoginService loginService = Get.find<LoginService>();

  final Rx<PostModel> _postModel = PostModel().obs;

  set postModel(value) => _postModel.value = value;

  PostModel get postModel => _postModel.value;

  final RxBool _isLoadedPost = false.obs;

  set isLoadedPost(value) => _isLoadedPost.value = value;

  bool get isLoadedPost => _isLoadedPost.value;

  @override
  void onInit() {
    final int id = Get.arguments;
    postController
        .getPost(loginService.loginModel.accessToken, id)
        .then((value) {
      if (value != null) {
        _postModel.value = value;
        _isLoadedPost.value = true;
      }
    });
    super.onInit();
  }
}
