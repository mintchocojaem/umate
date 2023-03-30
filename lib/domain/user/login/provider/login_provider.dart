import 'package:danvery/utils/dto/api_response_dto.dart';
import 'package:danvery/utils/dto/exception/exception_response_dto.dart';
import 'package:danvery/utils/dto/success/success_response_dto.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../model/login_model.dart';

class LoginProvider {
  final Dio _dio;

  static final LoginProvider _singleton =
      LoginProvider.internal(DioInterceptor().dio);

  LoginProvider.internal(this._dio);

  factory LoginProvider() => _singleton;

  Future<ApiResponseDTO> getLogin(String classId, String password) async {
    const String url = '/user/login';
    final body = {"studentId": classId, "password": password};

    try {
      final Response response = await _dio.post(
        url,
        data: body,
      );
      return SuccessResponseDTO(data: LoginModel.fromJson(response.data));
    } on DioError catch (e) {
      return ExceptionResponseDTO(message: e.message);
    }
  }
}
