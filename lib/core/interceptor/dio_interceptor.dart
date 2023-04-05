import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const String apiUrl = 'https://dev.dkustu.com/api';

class DioInterceptor {
  Dio dio = Dio();

  DioInterceptor._internal() {
    addInterceptors();
  }

  static final DioInterceptor _singleton = DioInterceptor._internal();

  factory DioInterceptor() => _singleton;

  void addInterceptors() {
    dio.options.baseUrl = apiUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.contentType = "application/json";
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // 요청 전에 처리할 내용 추가
      if (kDebugMode) {
        print("Dio Request : ${options.uri}");
      }
      return handler.next(options); // 다음 Interceptor 호출
    }, onResponse: (response, handler) {
      // 응답 처리 후에 처리할 내용 추가
      if (kDebugMode) {
        print("Dio Response : ${response.data}");
      }
      return handler.next(response); // 다음 Interceptor 호출
    }, onError: (DioError e, handler) {
      // 오류 처리 후에 처리할 내용 추가
      if (kDebugMode) {
        print(
            "Dio Error : code = ${e.response?.statusCode}, message = ${e.response?.data['message']}");
      }

      DioError dioError = DioError(
          requestOptions: e.requestOptions,
          message: (e.response?.data['message'] as List<dynamic>).join(', '),
          type: e.type,
      );

      return handler.next(dioError); // 다음 Interceptor 호출
    }));
  }
}
