typedef OnRequest = Future<void> Function(dynamic options);
typedef OnResponse = Future<void> Function(dynamic response);
typedef OnError = Future<void> Function(dynamic exception);

abstract class Client {
  late final String baseUrl;
  late final Duration connectTimeout;
  late final Duration receiveTimeout;
  late final Duration sendTimeout;
  late final Map<String, dynamic>? headers;

  late final OnRequest? onRequest;
  late final OnResponse? onResponse;
  late final OnError? onError;

  void setupOptions({
    required String baseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required Duration sendTimeout,
    Map<String, dynamic>? headers,
  });

  void setupInterceptors({
    OnRequest? onRequest,
    OnResponse? onResponse,
    OnError? onError,
  });

}
