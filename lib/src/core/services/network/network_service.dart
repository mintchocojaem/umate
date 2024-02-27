import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design_system/orb/components/components.dart';
import '../../constants/api_url.dart';

final networkServiceProvider = Provider<NetworkService>((ref) {
  final networkService = NetworkService();
  return networkService;
});

enum RequestType {
  get("GET"),
  post("POST"),
  patch("PATCH"),
  delete("DELETE");

  final String value;

  const RequestType(this.value);
}

base class NetworkService {
  final Dio _dio = Dio();
  final List<CancelToken> _cancelTokens = [];

  NetworkService(){
    _initialize();
  }

  Dio get dio => _dio;

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
            print('DioClient > (Response) : ${response.data}');
          }
          handler.next(response);
        },
        onError: (dioException, handler) async {
          if (dioException.type == DioExceptionType.cancel) {
            if (kDebugMode) {
              print('DioClient > (Canceled) : ${dioException.requestOptions.uri}');
            }
          } else {
            final List<dynamic> message =
                dioException.response?.data['message'] ?? ["알 수 없는 오류가 발생했어요!"];
            final int statusCode = dioException.response?.statusCode ?? 500;

            if (kDebugMode) {
              print(
                  'DioClient > (Error) : code = $statusCode : message = $message');
            }

            for (var message in message) {
              OrbSnackBar.show(
                message: message.toString(),
                type: OrbSnackBarType.error,
              );
            }
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
