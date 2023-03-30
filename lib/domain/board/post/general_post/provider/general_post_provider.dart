import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/utils/dto/api_response_dto.dart';
import 'package:danvery/utils/dto/exception/exception_response_dto.dart';
import 'package:danvery/utils/dto/success/success_response_dto.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class GeneralPostProvider {
  final Dio _dio;

  static final GeneralPostProvider _singleton =
      GeneralPostProvider._internal(DioInterceptor().dio);

  GeneralPostProvider._internal(this._dio);

  factory GeneralPostProvider() => _singleton;

  Future<ApiResponseDTO> writeGeneralPost(
      String token, GeneralPostModel postModel) async {
    String url = '/post/general-forum';

    final data = FormData.fromMap({
      'title': postModel.title,
      'body': postModel.body,
    });

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.post(url,
          data: data,
          options:
              Options(contentType: "multipart/form-data", headers: headers));

      return SuccessResponseDTO(data: GeneralPostModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> deleteGeneralPost(String token, int id) async {
    String url = '/post/general-forum/$id';

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

  Future<ApiResponseDTO> getGeneralPost(String token, int id) async {
    String url = '/post/general-forum/$id';

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
}
