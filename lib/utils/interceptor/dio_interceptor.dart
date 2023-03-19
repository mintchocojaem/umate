import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const String apiUrl = 'https://dev.dkustu.com/api';

class DioInterceptor {
  final Dio dio = Dio();

  DioInterceptor._internal(dio) {
    addInterceptors();
  }

  static final DioInterceptor _singleton =
      DioInterceptor._internal(Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {'Content-Type': 'application/json'},
    responseType: ResponseType.bytes,
  )));

  factory DioInterceptor() => _singleton;

  void addInterceptors() {
    dio.options.baseUrl = apiUrl;
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
      return handler.next(e); // 다음 Interceptor 호출
    }));
  }
}
