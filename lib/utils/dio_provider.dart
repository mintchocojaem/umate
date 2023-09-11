import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_constants.dart';


final dioProvider = Provider<Dio>((ref) => DioClient().dio);

class DioClient {
  final Dio dio = Dio();

  DioClient() {
    dio.options = BaseOptions(
        baseUrl: developmentBaseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        contentType: "application/json");
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 요청 전에 처리할 내용 추가
          if (kDebugMode) {
            print("Dio Request : ${options.uri}");
          }
          return handler.next(options); // 다음 Interceptor 호출
        },
        onResponse: (response, handler) {
          // 응답 처리 후에 처리할 내용 추가
          if (kDebugMode) {
            print("Dio Response : ${response.data}");
          }
          return handler.next(response); // 다음 Interceptor 호출
        },
        onError: (DioException e, handler) async{
          // 에러 처리 후에 처리할 내용 추가

          if (kDebugMode) {
            //print("Dio Error : ${e.response?.data['message']}");
          }

          return handler.next(e); // 다음 Interceptor 호출
        },
      ),
    );
  }
}
