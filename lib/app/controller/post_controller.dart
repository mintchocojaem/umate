import 'package:danvery/app/data/model/post_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repository/post_repository.dart';

class PostController extends GetxController {

  final _postRepository = PostRepository();

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> createPost(String token, PostModel postModel) {
    return _postRepository.createPost(token, postModel);
  }

}
