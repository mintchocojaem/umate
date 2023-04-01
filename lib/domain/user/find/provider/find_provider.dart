import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class FindProvider {
  final Dio _dio;

  static final FindProvider _singleton =
      FindProvider.internal(DioInterceptor().dio);

  FindProvider.internal(this._dio);

  factory FindProvider() => _singleton;

  Future<ApiResponseDTO> sendIdToSMS(String phoneNumber) async {
    const String url = '/user/find/id';
    final body = {"phoneNumber": phoneNumber};

    try {
      final Response response = await _dio.post(url, data: body,);
      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e){
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> sendAuthCodeToSMS(String phoneNumber) async {
    const String url = '/user/find/pwd';
    final body = {"phoneNumber": phoneNumber};

    try {
      final Response response = await _dio.post(url, data: body,);

      return SuccessResponseDTO(data: response.data['token']);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> verifyAuthCode(String token, String code) async {
    const String url = '/user/find/pwd/verify';
    final body = {"token": token, "code": code};

    try {
      final Response response = await _dio.post(url, data: body,);

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e){
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> changePassword(String token, String password) async {
    const String url = '/user/find/pwd/reset';
    final body = {"token": token, "password": password};

    try {
      final Response response =  await _dio.patch(url, data: body,);

      return SuccessResponseDTO(data: response);
    } on DioError catch (e){
      return ExceptionResponseDTO(message: e.message);
    }
  }

}
