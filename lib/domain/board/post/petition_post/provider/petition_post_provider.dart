import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_write_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class PetitionPostProvider {
  final Dio _dio;

  PetitionPostProvider._internal(this._dio);

  static final PetitionPostProvider singleton =
      PetitionPostProvider._internal(DioInterceptor().dio);

  factory PetitionPostProvider() => singleton;

  Future<ApiResponseDTO> getPetitionPost(String token, int petitionId) async {
    String url = '/post/petition/$petitionId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.get(url,
          options: Options(
            headers: headers,
          ));

      return SuccessResponseDTO(
          data: PetitionPostModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> writePetitionPost(
      String token, PetitionPostWriteModel petitionPostWriteModel) async {
    String url = '/post/petition';

    final data = FormData.fromMap({
      'title': petitionPostWriteModel.title,
      'body': petitionPostWriteModel.body,
      'tagIds': petitionPostWriteModel.tagIds.map((e) => e).toList(),
      'files': petitionPostWriteModel.files
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

  Future<ApiResponseDTO> deletePetitionPost(String token, int postId) async {
    String url = '/post/petition/$postId';

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

  Future<ApiResponseDTO> agreePetitionPost(String token, int petitionId) async {
    String url = '/post/petition/agree/$petitionId';

    final headers = {
      'Authorization': "Bearer $token",
    };

    try {
      final Response response = await _dio.post(url,
          options: Options(
            headers: headers,
          ));

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> blindPetitionPost(String token, int postId) async {
    String url = '/post/petition/blind/$postId';

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

  Future<ApiResponseDTO> unBlindPetitionPost(String token, int postId) async {
    String url = '/post/petition/unblind/$postId';

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

  Future<ApiResponseDTO> reportPetitionPost(
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
