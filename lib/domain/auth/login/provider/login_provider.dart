import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../model/login_model.dart';

class LoginProvider {
  final Dio _dio;

  static final LoginProvider _singleton =
      LoginProvider.internal(DioInterceptor().dio);

  LoginProvider.internal(this._dio);

  factory LoginProvider() => _singleton;

  Future<LoginModel?> getLogin(String classId, String password) async {
    const String url = '/user/login';
    final body = {"studentId": classId, "password": password};

    try {
      final Response response = await _dio.post(
        url,
        data: body,
      );
      return LoginModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }
}
