import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/core.dart';
import '../data.dart';

base class BaseRepository{
  final DioClient _dioClient = DioClient(
    baseUrl: developmentBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
    onRequest: (options) async {
      // 요청 전에 처리할 내용 추가
      if (kDebugMode) {
        print("Dio > (Request) ${options.uri}");
      }
      //Request 딜레이
      await Future.delayed(const Duration(milliseconds: 500));
    },
    onResponse: (response) async {
      // 응답 전에 처리할 내용 추가
      if (kDebugMode) {
        print("Dio > (Response) ${response.data}");
      }
    },
    onError: (exception) async {
      // 에러 전에 처리할 내용 추가
      final messages = (exception.response?.data['message'] as List<dynamic>?);

      if (exception.type != DioExceptionType.cancel) {
        final int statusCode = exception.response?.statusCode ?? 500;
        if (kDebugMode) {
          print(
              "Dio > (Error) code = $statusCode, message = ${messages.toString()}");
        }
      }

      OrbSnackBar.show(
        type: OrbSnackBarType.error,
        message: messages?.first.toString() ?? '알 수 없는 오류가 발생했습니다.',
      );
    },
  );

  Future<Response?> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    return await _dioRequest(
      request: () async {
        return await _dioClient.dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
      },
    );
  }

  Future<Response?> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    return await _dioRequest(
      request: () async {
        return await _dioClient.dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
      },
    );
  }

  Future<Response?> patch({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    return await _dioRequest(
      request: () async {
        return await _dioClient.dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
      },
    );
  }

  Future<Response?> _dioRequest({
    required Future<Response> Function() request,
  }) async {
    //dio request 할 때 공통적으로 처리할 내용 추가
    return await request();
  }

}
