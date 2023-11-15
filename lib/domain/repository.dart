import 'package:dio/dio.dart';

import '../utils/exception_handler.dart';

abstract base class Repository {
  final Dio dio;
  final ExceptionHandler exceptionHandler = ExceptionHandler();
  Repository(this.dio);

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameter,
    bool allowDuplicateRequest = true,
  }) async {
    return await dio.get(
      path,
      queryParameters: queryParameter,
      cancelToken: allowDuplicateRequest ? null : CancelToken(),
    );
  }

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? data,
    bool allowDuplicateRequest = true,
    Map<String, dynamic>? queryParameter,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameter,
      cancelToken: allowDuplicateRequest ? null : CancelToken(),
    );
  }

  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? data,
    bool allowDuplicateRequest = true,
  }) async {
    return await dio.patch(
      path,
      data: data,
      cancelToken: allowDuplicateRequest ? null : CancelToken(),
    );
  }

}
