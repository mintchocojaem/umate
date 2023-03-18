


import '../model/post_model.dart';
import '../provider/post_provider.dart';

class PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<bool> createPost(String token, PostModel postModel) => _postProvider.createPost(token, postModel);

  Future<bool> deletePost(String token, int id) => _postProvider.deletePost(token, id);

  Future<PostModel?> getPost(String token, int id) => _postProvider.getPost(token, id);

  //get suggestion board list
  Future<List<PostModel>?> getGeneralBoard(int page, int size) async {
    return await _postProvider.getGeneralBoard(page, size);
  }

}
