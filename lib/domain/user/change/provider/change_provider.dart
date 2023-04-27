import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class ChangeProvider {
  final Dio _dio;

  static final ChangeProvider _singleton =
      ChangeProvider.internal(DioInterceptor().dio);

  ChangeProvider.internal(this._dio);

  factory ChangeProvider() => _singleton;

  Future<ApiResponseDTO> changePassword(
      {required String accessToken,
      required String currentPassword,
      required String newPassword}) async {
    const String url = '/user/change/password';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final body = {
      "password": currentPassword,
      "newPassword": newPassword,
    };

    try {
      final Response response = await _dio.patch(
        url,
        data: body,
        options: Options(headers: headers),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> changeNickname(
      {required String accessToken, required String nickName}) async {
    const String url = '/user/change/nickname';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final body = {
      "nickname": nickName,
    };

    try {
      final Response response = await _dio.patch(
        url,
        data: body,
        options: Options(headers: headers),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> verifySMS(
      {required String accessToken, required String phoneNumber}) async {
    const String url = '/user/change/phone/verify';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final body = {
      "phoneNumber": phoneNumber,
    };

    try {
      final Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> changePhoneNumber(
      {required String accessToken,
      required String token,
      required String code}) async {
    const String url = '/user/change/phone';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final body = {
      "token": token,
      "code": code,
    };

    try {
      final Response response = await _dio.patch(
        url,
        data: body,
        options: Options(headers: headers),
      );

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

}
