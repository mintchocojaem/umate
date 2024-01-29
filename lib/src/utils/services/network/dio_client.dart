import 'package:dio/dio.dart';

enum RequestType {
  get("GET"),
  post("POST"),
  patch("PATCH"),
  delete("DELETE");

  final String value;

  const RequestType(this.value);
}

typedef OnRequest = Future<void> Function(RequestOptions options);
typedef OnResponse = Future<void> Function(Response response);
typedef OnError = Future<void> Function(DioException dioException);

base class DioClient {
  final Dio _dio = Dio();

  final List<CancelToken> _cancelTokens = [];

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
    _dio.options = BaseOptions(
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
    _dio.interceptors.add(
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

  CancelToken getCancelToken() {
    final cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);
    return cancelToken;
  }

  void cancelRequest(CancelToken cancelToken) {
    cancelToken.cancel();
    _cancelTokens.remove(cancelToken);
  }

  void cancelAllRequests() {
    for (var cancelToken in _cancelTokens) {
      cancelToken.cancel();
    }
    _cancelTokens.clear();
  }

  void removeCancelToken(CancelToken cancelToken) {
    _cancelTokens.remove(cancelToken);
  }

  Future<Response> request({
    required String path,
    required RequestType method,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final cancelToken = getCancelToken();

    final response = await _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: method.value),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return response;
  }
}
