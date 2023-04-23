import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_wirte_model.dart';

import '../provider/general_post_provider.dart';

class GeneralPostRepository {
  final GeneralPostProvider _generalPostProvider;

  static final GeneralPostRepository _singleton =
      GeneralPostRepository._internal(GeneralPostProvider());

  GeneralPostRepository._internal(this._generalPostProvider);

  factory GeneralPostRepository() => _singleton;

  Future<ApiResponseDTO> writeGeneralPost(
          {required String token, required GeneralPostWriteModel generalPostWriteModel}) =>
      _generalPostProvider.writeGeneralPost(token, generalPostWriteModel);

  Future<ApiResponseDTO> deleteGeneralPost({required String token, required int postId}) =>
      _generalPostProvider.deleteGeneralPost(token, postId);

  Future<ApiResponseDTO> getGeneralPost(
          {required String token, required int postId}) =>
      _generalPostProvider.getGeneralPost(token, postId);

  Future<ApiResponseDTO> getGeneralComment(
      {required String token,
        required int commentId,
        required int page,
        required int size}) async {
    return await _generalPostProvider.getGeneralComment(
        token, commentId, page, size);
  }

  Future<ApiResponseDTO> writeGeneralComment(
      {required String token,
        required int commentId,
        required String text}) async {
    return await _generalPostProvider.writeGeneralComment(
        token, commentId, text);
  }

  Future<ApiResponseDTO> deleteGeneralComment(
      {required String token,
        required int commentId}) async {
    return await _generalPostProvider.deleteGeneralComment(
        token, commentId);
  }

  Future<ApiResponseDTO> likePost(
      {required String token, required int postId}) async {
    return await _generalPostProvider.likePost(token, postId);
  }

  Future<ApiResponseDTO> unlikePost(
      {required String token, required int postId}) async {
    return await _generalPostProvider.unlikePost(token, postId);
  }

  Future<ApiResponseDTO> blindPost(
      {required String token, required int postId}) async {
    return await _generalPostProvider.blindPost(token, postId);
  }

  Future<ApiResponseDTO> unBlindPost(
      {required String token, required int postId}) async {
    return await _generalPostProvider.unBlindPost(token, postId);
  }

  Future<ApiResponseDTO> reportPost(
      {required String token, required int postId, required String categoryName}) async {
    return await _generalPostProvider.reportPost(token, postId, categoryName);
  }

}
