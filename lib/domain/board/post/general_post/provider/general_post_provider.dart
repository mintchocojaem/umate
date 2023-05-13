
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/board/post/general_post/model/general_comment_list_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_wirte_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class GeneralPostProvider {
  final Dio _dio;

  GeneralPostProvider._internal(this._dio);

  static final GeneralPostProvider _singleton =
      GeneralPostProvider._internal(DioInterceptor().dio);

  factory GeneralPostProvider() => _singleton;

  Future<ApiResponseDTO> writeGeneralPost(
      String token, GeneralPostWriteModel generalPostWriteModel) async {
    String url = '/post/general-forum';

    final data = FormData.fromMap({
      'title': generalPostWriteModel.title,
      'body': generalPostWriteModel.body,
      'files': generalPostWriteModel.files
          .map(
            (e) => MultipartFile.fromFileSync(
              e.url,
              contentType: MediaType(
                e.mimeType.split('/')[0],
                e.mimeType.split('/')[1],
              ),
            ),
          )
          .toList(),
    });
    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: Options(
          contentType: "multipart/form-data",
          headers: headers,
        ),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> deleteGeneralPost(String token, int postId) async {
    String url = '/post/general-forum/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response =
          await _dio.delete(url, options: Options(headers: headers));

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> getGeneralPost(String token, int postId) async {
    String url = '/post/general-forum/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      return SuccessResponseDTO(data: GeneralPostModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> getGeneralComment(
      String token, int commentId, int page, int size) async {
    String url =
        '/post/general-forum/comment/$commentId?page=$page&size=$size&sort=createdAt,asc';

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
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> writeGeneralComment(
      String token, int commentId, String text) async {
    String url = '/post/general-forum/comment/$commentId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    final data = {
      'text': text,
    };

    try {
      final Response response = await _dio.post(url,
          options: Options(
            headers: headers,
          ),
          data: data);

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> deleteGeneralComment(
      String token, int commentId) async {
    String url = '/post/general-forum/comment/$commentId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
        ),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> likeGeneralPost(String token, int postId) async {
    String url = '/post/general-forum/like/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.post(
        url,
        options: Options(
          headers: headers,
        ),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> unlikeGeneralPost(String token, int postId) async {
    String url = '/post/general-forum/like/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
        ),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> blindGeneralPost(String token, int postId) async {
    String url = '/post/general-forum/blind/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.patch(
        url,
        options: Options(
          headers: headers,
        ),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> unBlindGeneralPost(String token, int postId) async {
    String url = '/post/general-forum/unblind/$postId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.patch(
        url,
        options: Options(
          headers: headers,
        ),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> reportGeneralPost(
      String token, int postId, String categoryName) async {
    String url = '/report/$postId?categoryName=$categoryName';

    final headers = {
      'Authorization': "Bearer $token",
    };

    final data = {
      "categoryName": categoryName,
    };

    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }
}
