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
          {required String token,
          required GeneralPostWriteModel generalPostWriteModel}) =>
      _generalPostProvider.writeGeneralPost(token, generalPostWriteModel);

  Future<ApiResponseDTO> deleteGeneralPost(
          {required String token, required int postId}) =>
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
      {required String token, required int commentId}) async {
    return await _generalPostProvider.deleteGeneralComment(token, commentId);
  }

  Future<ApiResponseDTO> likeGeneralPost(
      {required String token, required int postId}) async {
    return await _generalPostProvider.likeGeneralPost(token, postId);
  }

  Future<ApiResponseDTO> unlikeGeneralPost(
      {required String token, required int postId}) async {
    return await _generalPostProvider.unlikeGeneralPost(token, postId);
  }

  Future<ApiResponseDTO> blindGeneralPost(
      {required String token, required int postId}) async {
    return await _generalPostProvider.blindGeneralPost(token, postId);
  }

  Future<ApiResponseDTO> unBlindGeneralPost(
      {required String token, required int postId}) async {
    return await _generalPostProvider.unBlindGeneralPost(token, postId);
  }

  Future<ApiResponseDTO> reportGeneralPost(
      {required String token,
      required int postId,
      required String categoryName}) async {
    return await _generalPostProvider.reportGeneralPost(
        token, postId, categoryName);
  }
}
