import 'package:danvery/app/data/model/post_model.dart';
import 'package:get/get.dart';

import '../data/repository/post_repository.dart';

class PostController extends GetxController {

  final PostRepository postRepository;

  PostController({required this.postRepository});

  Future<bool> createPost(String token, PostModel postModel) {
    return postRepository.createPost(token, postModel);
  }

  Future<bool> deletePost(String token, int id) {
    return postRepository.deletePost(token, id);
  }

  Future<PostModel?> getPost(String token, int id) {
    return postRepository.getPost(token, id);
  }

}
