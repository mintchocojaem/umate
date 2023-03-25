import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';

import '../provider/general_post_provider.dart';

class GeneralPostRepository {

  final GeneralPostProvider _generalPostProvider;

  static final GeneralPostRepository _singleton =
      GeneralPostRepository._internal(GeneralPostProvider());

  GeneralPostRepository._internal(this._generalPostProvider);

  factory GeneralPostRepository() => _singleton;

  Future<bool> createGeneralPost(String token, GeneralPostModel postModel) =>
      _generalPostProvider.createGeneralPost(token, postModel);

  Future<bool> deleteGeneralPost(String token, int id) =>
      _generalPostProvider.deleteGeneralPost(token, id);

  Future<GeneralPostModel?> getGeneralPost(String token, int id) =>
      _generalPostProvider.getGeneralPost(token, id);

  //get suggestion board list
  Future<List<GeneralPostModel>?> getGeneralBoard(int page, int size) async {
    return await _generalPostProvider.getGeneralBoard(page, size);
  }
}
