
abstract class Client<T, U, V> {
  late final String baseUrl;
  late final Duration connectTimeout;
  late final Duration receiveTimeout;
  late final Duration sendTimeout;
  Map<String, dynamic>? headers;

  Future<void> Function(T)? onRequest;
  Future<void> Function(U)? onResponse;
  Future<void> Function(V)? onError;

  void setupOptions({
    required String baseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required Duration sendTimeout,
    Map<String, dynamic>? headers,
  });

  void setupInterceptors({
    Future<void> Function(T)? onRequest,
    Future<void> Function(U)? onResponse,
    Future<void> Function(V)? onError,
  });

}
