
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/auth/token/token.dart';
import '../domain/auth/token/token_provider.dart';
import 'api_constants.dart';
import 'exception_handler.dart';

final dioProvider = Provider<Dio>((ref) => DioClient(ref).dio);

class DioClient {
  final Dio dio = Dio();
  final ExceptionHandler exceptionHandler = ExceptionHandler();
  final Ref ref;

  final List<RequestOptions> _pendingRequests = [];

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

          bool isPending = false; // 동일한 요청이 있는지 확인

          for (final pendingRequest in _pendingRequests) {
            if (pendingRequest.path == options.path &&
                pendingRequest.cancelToken != null) {
              // 동일한 요청이 있으면 이전 요청은 취소
              isPending = true;
              pendingRequest.cancelToken?.cancel();
              if (kDebugMode) {
                print("Dio canceled request : ${pendingRequest.uri}");
              }
            }
          }

          if (isPending) {
            // 동일한 요청이 있으면 기존 요청 제거
            _pendingRequests
                .removeWhere((element) => element.path == options.path);
          }

          _pendingRequests.add(options);

          final Token? token = ref.read(tokenProvider).value;

          if (token == null) {
            //find, login, signup 할땐 토큰 넣으면 안됨 -> 만료된 상태면 오류남
            options.headers.addAll(
              {
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyUm9sZSI6IlJPTEVfQURNSU4sUk9MRV9VU0VSIiwiZXhwIjoxNzAwODEyNjU5LCJ1c2VySWQiOiIxMSIsImlhdCI6MTcwMDU1MzQ1OX0.ypayLKMfwzOYHsFozMll3U11_gJkyz_PowIMnOjJ0s4"
              },
            );
          }

          if (kDebugMode) {
            print("Dio request : ${options.uri}");
          }

          await Future.delayed(const Duration(milliseconds: 500));

          return handler.next(options); // 다음 Interceptor 호출
        },
        onResponse: (response, handler) {
          // 응답 처리 후에 처리할 내용 추가
          if (kDebugMode) {
            print("Dio response : ${response.data}");
          }
          _pendingRequests.removeWhere(
              (element) => element.path == response.requestOptions.path);

          return handler.next(response); // 다음 Interceptor 호출
        },
        onError: (DioException e, handler) {
          // 에러 처리 후에 처리할 내용 추가
          if (e.type != DioExceptionType.cancel) {
            final exception = e.response?.data == null
                ? const ExceptionDto()
                : ExceptionDto(
                    code: e.response!.data['code'].toString(),
                    message: e.response!.data['message'].first.toString(),
                  );
            exceptionHandler.invokeException(exception.message);
          }

          return handler.next(e); // 다음 Interceptor 호출
        },
      ),
    );
  }
}
