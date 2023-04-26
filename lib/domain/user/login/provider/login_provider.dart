import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/dto/exception/exception_response_dto.dart';
import 'package:danvery/core/dto/success/success_response_dto.dart';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/domain/user/login/model/token_model.dart';
import 'package:danvery/domain/user/login/model/user_info_model.dart';
import 'package:dio/dio.dart';

class LoginProvider {
  final Dio _dio;

  LoginProvider.internal(this._dio);

  static final LoginProvider _singleton =
      LoginProvider.internal(DioInterceptor().dio);

  factory LoginProvider() => _singleton;

  Future<ApiResponseDTO> getLogin(String classId, String password) async {
    const String url = '/user/login';
    final body = {"studentId": classId, "password": password};

    try {
      final Response response = await _dio.post(
        url,
        data: body,
      );
      return SuccessResponseDTO(data: TokenModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> reissueToken(String accessToken, String refreshToken) async {
    const String url = '/user/reissue';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };
    final body = {"refreshToken": refreshToken};

    try {
      final Response response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return SuccessResponseDTO(data: TokenModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }

  Future<ApiResponseDTO> getUserInfo(String accessToken) async{
    const String url = '/user';
    final headers = {
      'Authorization': "Bearer $accessToken",
    };

    try {
      final Response response = await _dio.get(
        url,
        options: Options(headers: headers),
      );
      return SuccessResponseDTO(data: UserInfoModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }



}
