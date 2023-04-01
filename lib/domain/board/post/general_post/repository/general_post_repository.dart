import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/core/dto/api_response_dto.dart';

import '../provider/general_post_provider.dart';

class GeneralPostRepository {
  final GeneralPostProvider _generalPostProvider;

  static final GeneralPostRepository _singleton =
      GeneralPostRepository._internal(GeneralPostProvider());

  GeneralPostRepository._internal(this._generalPostProvider);

  factory GeneralPostRepository() => _singleton;

  Future<ApiResponseDTO> writeGeneralPost(
          {required String token, required GeneralPostModel postModel}) =>
      _generalPostProvider.writeGeneralPost(token, postModel);

  Future<ApiResponseDTO> deleteGeneralPost({required String token, required int id}) =>
      _generalPostProvider.deleteGeneralPost(token, id);

  Future<ApiResponseDTO> getGeneralPost(
          {required String token, required int id}) =>
      _generalPostProvider.getGeneralPost(token, id);

  Future<ApiResponseDTO> getGeneralComment(
      {required String token,
        required int id,
        required int page,
        required int size}) async {
    return await _generalPostProvider.getGeneralComment(
        token, id, page, size);
  }

  Future<ApiResponseDTO> likePost(
      {required String token, required int id}) async {
    return await _generalPostProvider.likePost(token, id);
  }

  Future<ApiResponseDTO> unlikePost(
      {required String token, required int id}) async {
    return await _generalPostProvider.unlikePost(token, id);
  }

}
