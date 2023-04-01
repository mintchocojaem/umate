import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../model/register_model.dart';

class RegisterProvider {
  final Dio _dio;

  static final RegisterProvider _singleton =
      RegisterProvider._internal(DioInterceptor().dio);

  RegisterProvider._internal(this._dio);

  factory RegisterProvider() => _singleton;

  Future<ApiResponseDTO> studentAuth(String id, String password) async {
    String url = '/user/dku/verify';
    final body = {"dkuStudentId": id, "dkuPassword": password};

    try {
      final Response response = await _dio.post(url, data: body);

      return SuccessResponseDTO(data: RegisterModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> register(RegisterModel registerModel) async {
    String url = '/user/${registerModel.signupToken}';
    final body = {
      "nickname": registerModel.nickname,
      "password": registerModel.password
    };

    try {
      final Response response = await _dio.post(url, data: body);

      return SuccessResponseDTO(data: RegisterModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> sendAuthCodeToSMS(String signupToken, String phoneNumber) async {
    String url = '/user/sms/$signupToken';
    final body = {'phoneNumber': phoneNumber};

    try {
      final Response response = await _dio.post(url, data: body);

      return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> verifyAuthCodeToSMS(String signupToken, String code) async {
    String url = '/user/sms/verify/$signupToken';
    final body = {'code': code};

    try {
      final Response response = await _dio.post(url, data: body);

       return SuccessResponseDTO(data: response.data);
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

}
