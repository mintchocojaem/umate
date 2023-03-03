import 'package:danvery/app/data/model/post_model.dart';

import '../provider/post_provider.dart';

class PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<bool> createPost(String token, PostModel postModel) => _postProvider.createPost(token, postModel);

}
