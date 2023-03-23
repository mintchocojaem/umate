


import '../model/general_post_model.dart';
import '../provider/general_post_provider.dart';

class GeneralPostRepository {
  final GeneralPostProvider postProvider;

  GeneralPostRepository({required this.postProvider});

  Future<bool> createGeneralPost(String token, GeneralPostModel postModel) => postProvider.createGeneralPost(token, postModel);

  Future<bool> deleteGeneralPost(String token, int id) => postProvider.deleteGeneralPost(token, id);

  Future<GeneralPostModel?> getGeneralPost(String token, int id) => postProvider.getGeneralPost(token, id);

  //get suggestion board list
  Future<List<GeneralPostModel>?> getGeneralBoard(int page, int size) async {
    return await postProvider.getGeneralBoard(page, size);
  }

}
