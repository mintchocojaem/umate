import 'package:dio/dio.dart';

typedef OnRequest = Future<void> Function(RequestOptions options);
typedef OnResponse = Future<void> Function(Response response);
typedef OnError = Future<void> Function(DioException dioException);

base class DioClient {
  final Dio dio = Dio();

  DioClient({
    required String baseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required Duration sendTimeout,
    Map<String, dynamic>? headers,
    OnRequest? onRequest,
    OnResponse? onResponse,
    OnError? onError,
  }) {
    _setupOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: headers,
    );
    _setupInterceptors(
      onRequest: onRequest,
      onResponse: onResponse,
      onError: onError,
    );
  }

  void _setupOptions({
    required String baseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required Duration sendTimeout,
    Map<String, dynamic>? headers,
  }) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: headers,
    );
  }

  void _setupInterceptors({
    Future<void> Function(RequestOptions)? onRequest,
    Future<void> Function(Response response)? onResponse,
    Future<void> Function(DioException dioException)? onError,
  }) async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 요청 전에 처리할 내용 추가
          await onRequest?.call(options);

          return handler.next(options); // 다음 Interceptor 호출
        },
        onResponse: (response, handler) async {
          // 응답 처리 후에 처리할 내용 추가
          await onResponse?.call(response);

          return handler.next(response); // 다음 Interceptor 호출
        },
        onError: (DioException e, handler) async {
          // 에러 처리 후에 처리할 내용 추가
          await onError?.call(e);

          return handler.next(e); // 다음 Interceptor 호출
        },
      ),
    );
  }
}
