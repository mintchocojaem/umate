import 'package:danvery/domain/board/comment/general_comment/model/general_comment_list_model.dart';
import 'package:danvery/utils/dto/api_response_dto.dart';
import 'package:danvery/utils/dto/exception/exception_response_dto.dart';
import 'package:danvery/utils/dto/success/success_response_dto.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class GeneralCommentProvider {
  final Dio _dio;

  static final GeneralCommentProvider _singleton =
      GeneralCommentProvider._internal(DioInterceptor().dio);

  GeneralCommentProvider._internal(this._dio);

  factory GeneralCommentProvider() => _singleton;

  Future<ApiResponseDTO> getGeneralComment(
      String token, int id, int page, int size) async {
    String url = '/post/general-forum/comment/$id?page=$page&size=$size';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      return SuccessResponseDTO(
          data: GeneralCommentListModel.fromJson(response.data));
    }  on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }
}
