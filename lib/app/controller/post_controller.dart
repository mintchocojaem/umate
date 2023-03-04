import 'package:danvery/app/data/model/post_model.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../data/repository/post_repository.dart';
import 'login_controller.dart';

class PostController extends GetxController {

  final _postRepository = PostRepository();

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> createPost(String token, PostModel postModel) {
    return _postRepository.createPost(token, postModel);
  }

  Future<bool> deletePost(String token, int id) {
    return _postRepository.deletePost(token, id);
  }

}
