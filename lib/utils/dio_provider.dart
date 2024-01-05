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
      headers: {
        "accept": "application/json",
      },
    );
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

          options.headers.addAll(
            {
              "Authorization": token != null
                  ? "Bearer ${token.accessToken}"
                  : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyUm9sZSI6IlJPTEVfQURNSU4sUk9MRV9VU0VSIiwiZXhwIjoxNzA0NDM2ODE3LCJ1c2VySWQiOiI0IiwiaWF0IjoxNzA0MTc3NjE3fQ.5qor5BY18rQ4jLB4hIf5zyDdrMsZBmH2Kp8xCXThbyI"
            },
          );

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

          if((e.response?.statusCode ?? 403) > 400){
            //http status code가 400 이상일 경우 토큰 문제로 간주
            ref.read(tokenProvider.notifier).logout();
          }

          return handler.next(e); // 다음 Interceptor 호출
        },
      ),
    );
  }
}
