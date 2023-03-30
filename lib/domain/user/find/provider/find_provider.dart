import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class FindProvider {
  final Dio _dio;

  static final FindProvider _singleton =
      FindProvider.internal(DioInterceptor().dio);

  FindProvider.internal(this._dio);

  factory FindProvider() => _singleton;

  Future<bool> sendIdToSMS(String phoneNumber) async {
    const String url = '/user/find/id';
    final body = {"phoneNumber": phoneNumber};

    try {
      await _dio.post(url, data: body,);

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> sendAuthCodeToSMS(String phoneNumber) async {
    const String url = '/user/find/pwd';
    final body = {"phoneNumber": phoneNumber};

    try {
      final Response response = await _dio.post(url, data: body,);

      return response.data['token'];
    } catch (_) {
      return null;
    }
  }

  Future<bool> verifyAuthCode(String token, String code) async {
    const String url = '/user/find/pwd/verify';
    final body = {"token": token, "code": code};

    try {
      await _dio.post(url, data: body,);

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> changePassword(String token, String password) async {
    const String url = '/user/find/pwd/reset';
    final body = {"token": token, "password": password};

    try {
      await _dio.patch(url, data: body,);

      return true;
    } catch (_) {
      return false;
    }
  }

}
