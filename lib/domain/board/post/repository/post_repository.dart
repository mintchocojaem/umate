


import '../model/post_model.dart';
import '../provider/post_provider.dart';

class PostRepository {
  final PostProvider postProvider;

  PostRepository({required this.postProvider});

  Future<bool> createPost(String token, PostModel postModel) => postProvider.createPost(token, postModel);

  Future<bool> deletePost(String token, int id) => postProvider.deletePost(token, id);

  Future<PostModel?> getPost(String token, int id) => postProvider.getPost(token, id);

  //get suggestion board list
  Future<List<PostModel>?> getGeneralBoard(int page, int size) async {
    return await postProvider.getGeneralBoard(page, size);
  }

}
