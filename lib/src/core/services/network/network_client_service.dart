import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/api_url.dart';
import '../../utils/app_exception.dart';

enum RequestType {
  get("GET"),
  post("POST"),
  patch("PATCH"),
  delete("DELETE");

  final String value;

  const RequestType(this.value);
}

base class NetworkClientService {
  NetworkClientService() {
    _initialize();
  }

  final Dio _dio = Dio();

  Dio get dio => _dio;

  final List<CancelToken> _cancelTokens = [];

  void _initialize() {
    _dio.options = BaseOptions(
      baseUrl: developmentBaseUrl,
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
            print('DioClient > (Request) : ${requestOptions.uri}');
          }
          await Future.delayed(const Duration(seconds: 1));
          handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          if (kDebugMode) {
            print('NetworkClientService > (Response) : ${response.data}');
          }
          handler.next(response);
        },
        onError: (dioException, handler) async {
          if (dioException.type == DioExceptionType.cancel) {
            if (kDebugMode) {
              print(
                  'NetworkClientService > (Canceled) : ${dioException.requestOptions.uri}');
            }
          } else {
            final List<dynamic> messages =
                dioException.response?.data['message'];

            String message = '서버 연결 중 오류가 발생했어요.';

            dynamic firstMessage = messages.firstOrNull;

            if (firstMessage != null && firstMessage is Map<String, dynamic>) {
              message = firstMessage['error'];
            } else if (firstMessage is String) {
              message = firstMessage;
            }

            final int statusCode = dioException.response?.statusCode ?? 500;

            if (kDebugMode) {
              print(
                  'NetworkClientService > (Error) : code = $statusCode, message = $messages');
            }
            dioException = dioException.copyWith(
              message: message,
            );
          }
          handler.next(dioException);
        },
      ),
    );
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

    try {
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
    } on DioException catch (error, stackTrace) {
      throw AppError(
        message: error.message,
        stackTrace: stackTrace,
      );
    } finally {
      removeCancelToken(cancelToken);
    }
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
}
