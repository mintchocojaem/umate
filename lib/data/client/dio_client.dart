import 'package:dio/dio.dart';

import '../data.dart';

base class DioClient implements Client{

  final Dio dio = Dio();

  @override
  late final String baseUrl;
  @override
  late final Duration connectTimeout;
  @override
  late final Duration receiveTimeout;
  @override
  late final Duration sendTimeout;
  @override
  late final Map<String, dynamic>? headers;

  @override
  late final OnRequest? onRequest;
  @override
  late final OnResponse? onResponse;
  @override
  late final OnError? onError;

  static final _instance = DioClient._internal();

  DioClient._internal();

  factory DioClient({
    required String baseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required Duration sendTimeout,
    Map<String, dynamic>? headers,
    OnRequest? onRequest,
    OnResponse? onResponse,
    OnError? onError,
  }) {
    _instance.onRequest = onRequest;
    _instance.onResponse = onResponse;
    _instance.onError = onError;

    _instance.setupOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: headers,
    );
    _instance.setupInterceptors(
      onRequest: onRequest,
      onResponse: onResponse,
      onError: onError,
    );

    return _instance;
  }

  @override
  void setupOptions({
    required String baseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required Duration sendTimeout,
    Map<String, dynamic>? headers,
  }) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout:receiveTimeout,
      sendTimeout: sendTimeout,
      headers: headers,
    );
  }

  @override
  void setupInterceptors({
    OnRequest? onRequest,
    OnResponse? onResponse,
    OnError? onError,
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
