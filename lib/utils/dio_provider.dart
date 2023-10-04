import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/auth/token/token.dart';
import '../domain/auth/token/token_provider.dart';
import 'api_constants.dart';

final dioProvider = Provider<Dio>((ref) => DioClient(ref).dio);

class DioClient {
  final Dio dio = Dio();
  final Ref ref;

  DioClient(this.ref) {
    dio.options = BaseOptions(
        baseUrl: developmentBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        contentType: "application/json");
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 요청 전에 처리할 내용 추가
          final Token? token = ref.read(tokenProvider).value;
          if(token == null){
            options.headers.addAll(
              {
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyUm9sZSI6IlJPTEVfQURNSU4sUk9MRV9VU0VSIiwiZXhwIjoxNjk2NjkyMzQ2LCJ1c2VySWQiOiIxMSIsImlhdCI6MTY5NjQzMzE0Nn0.7sbpKQLWCU56rSd1-bpGj1TmLEOMvhVr2tn39FtTIYQ",
              },
            );
          }
          if (kDebugMode) {
            print("Dio Request : ${options.uri}");
            await Future.delayed(const Duration(seconds: 2));
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
        onError: (DioException e, handler) async {
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
