import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:dio/dio.dart';

class FindProvider {
  final Dio _dio;

  static final FindProvider _singleton =
      FindProvider.internal(DioInterceptor().dio);

  FindProvider.internal(this._dio);

  factory FindProvider() => _singleton;

  Future<bool> sendId(String phoneNumber) async {
    const String url = '/user/find/id';
    final body = {"phoneNumber": phoneNumber};

    try {
      await _dio.post(url, data: body,);

      return true;
    } catch (_) {
      return false;
    }
  }
}
