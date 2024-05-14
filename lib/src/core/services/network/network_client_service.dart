import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../constants/api_url.dart';
import '../../utils/app_exception.dart';

final class AppNetworkError extends AppException {
  final DioExceptionType type;

  const AppNetworkError({
    required this.type,
    final String? message,
    required super.stackTrace,
  }) : super(message: message ?? '서버 연결 중 오류가 발생했어요.');

  @override
  toString() =>
      'AppNetworkError > message : $message, stackTrace : $stackTrace';
}

enum RequestType {
  get("GET"),
  post("POST"),
  patch("PATCH"),
  delete("DELETE");

  final String value;

  const RequestType(this.value);
}

base class NetworkClientService {
  final Future<void> Function(RequestOptions options) onRequest;
  final Future<void> Function(Response response) onResponse;
  final Future<void> Function(DioException exception) onError;

  NetworkClientService({
    required this.onRequest,
    required this.onResponse,
    required this.onError,
  }) {
    _initialize();
  }

  final Dio _dio = Dio();

  Dio get dio => _dio;

  void _initialize() {
    _dio.options = BaseOptions(
      baseUrl: kDebugMode ? developmentBaseUrl : productionBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) async {
          if (kDebugMode) {
            print(
                'NetworkClientService > (Request) : url = ${requestOptions.uri}, headers = ${requestOptions.headers}, data = ${requestOptions.data}');
          }
          await onRequest(requestOptions);
          handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          if (kDebugMode) {
            print(
                'NetworkClientService > (Response) : data = ${response.data}');
            await onResponse(response);
          }
          handler.next(response);
        },
        onError: (exception, handler) async {
          await onError(exception);

          if (exception.type == DioExceptionType.cancel) {
            if (kDebugMode) {
              print(
                  'NetworkClientService > (Canceled) : ${exception.requestOptions.uri}');
            }
          } else {
            final List<dynamic>? messages = exception.response?.data['message'];

            String message = '서버 연결 중 오류가 발생했어요.';

            dynamic firstMessage = messages?.firstOrNull;

            if (firstMessage != null && firstMessage is Map<String, dynamic>) {
              message = firstMessage['error'];
            } else if (firstMessage is String) {
              message = firstMessage;
            }

            exception = exception.copyWith(
              message: message,
            );

            final int statusCode = exception.response?.statusCode ?? 500;

            if (kDebugMode) {
              print(
                  'NetworkClientService > (Error) : code = $statusCode, message = $messages');
            }
          }
          handler.next(exception);
        },
      ),
    );
  }

  Future<Response> request({
    required String path,
    required RequestType method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method.value,
          headers: headers,
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (error, stackTrace) {
      throw AppNetworkError(
        type: error.type,
        message: error.message,
        stackTrace: stackTrace,
      );
    }
  }
}
