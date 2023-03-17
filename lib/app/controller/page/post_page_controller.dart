import 'package:danvery/app/controller/login_controller.dart';
import 'package:danvery/app/controller/post_controller.dart';
import 'package:danvery/app/data/model/post_model.dart';
import 'package:get/get.dart';

class PostPageController extends GetxController {

  final PostController _postController = Get.find<PostController>();
  final LoginController _loginController = Get.find<LoginController>();

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
