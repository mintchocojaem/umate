import 'package:danvery/domain/auth/login/services/login_service.dart';
import 'package:get/get.dart';

import '../../../../../../domain/board/petition/controller/post_controller.dart';
import '../../../../../../domain/board/post/model/post_model.dart';

class PostPageController extends GetxController {

  final PostController _postController = Get.find<PostController>();
  final LoginService _loginController = Get.find<LoginService>();

  final Rx<PostModel>_postModel = PostModel().obs;
  set postModel(value) => _postModel.value = value;
  PostModel get postModel => _postModel.value;

  final RxBool _isLoadedPost = false.obs;
  set isLoadedPost(value) => _isLoadedPost.value = value;
  bool get isLoadedPost => _isLoadedPost.value;

  @override
  void onInit() {
    final int id = Get.arguments;
    _postController.getPost(_loginController.loginModel.accessToken, id).then((value) {
      if(value != null){
        _postModel.value = value;
        _isLoadedPost.value = true;
      }
    });
    super.onInit();
  }

}
