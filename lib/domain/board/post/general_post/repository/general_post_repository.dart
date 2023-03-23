
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';

import '../provider/general_post_provider.dart';

class GeneralPostRepository {
  final GeneralPostProvider generalPostProvider;

  GeneralPostRepository({required this.generalPostProvider});

  Future<bool> createGeneralPost(String token, GeneralPostModel postModel) => generalPostProvider.createGeneralPost(token, postModel);

  Future<bool> deleteGeneralPost(String token, int id) => generalPostProvider.deleteGeneralPost(token, id);

  Future<GeneralPostModel?> getGeneralPost(String token, int id) => generalPostProvider.getGeneralPost(token, id);

  //get suggestion board list
  Future<List<GeneralPostModel>?> getGeneralBoard(int page, int size) async {
    return await generalPostProvider.getGeneralBoard(page, size);
  }

}
