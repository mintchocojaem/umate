import 'package:dio/dio.dart';
import '../data.dart';

base class DioClient implements Client<RequestOptions, Response, DioException> {
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
  Map<String, dynamic>? headers;

  @override
  Future<void> Function(RequestOptions requestOptions)? onRequest;
  @override
  Future<void> Function(Response response)? onResponse;
  @override
  Future<void> Function(DioException dioException)? onError;

  final bool isInitialized = false;

  static final _instance = DioClient._internal();

  DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient.init({
    required String baseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required Duration sendTimeout,
    Map<String, dynamic>? headers,
    this.onRequest,
    this.onResponse,
    this.onError,
  }) {
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
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: headers,
    );
  }

  @override
  void setupInterceptors({
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
