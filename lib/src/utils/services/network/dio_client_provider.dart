import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../modules/modules.dart';
import '../../utils.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(
    baseUrl: developmentBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
    onRequest: (requestOptions) async {
      // 요청 전에 처리할 내용 추가

      if (kDebugMode) {
        print('DioClient > (Request) : ${requestOptions.uri}');
      }

      await Future.delayed(const Duration(seconds: 2));
    },
    onResponse: (response) async {
      // 응답 전에 처리할 내용 추가

      if (kDebugMode) {
        print('DioClient > (Response) : ${response.data}');
      }
    },
    onError: (dioException) async {
      // 에러 전에 처리할 내용 추가

      if (dioException.type == DioExceptionType.cancel) {
        if (kDebugMode) {
          print('DioClient > (Canceled) : ${dioException.requestOptions.uri}');
        }
      } else {
        final List<dynamic> message = dioException.response?.data['message'];
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
    },
  );
});
