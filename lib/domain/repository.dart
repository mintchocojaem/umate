import 'package:dio/dio.dart';

abstract base class Repository {
  final Dio dio;

  Repository(this.dio);

  Future<Response?> get({
    required String path,
    Map<String, dynamic>? queryParameter,
    bool allowDuplicateRequest = true,
  }) async {
    try{
      return await dio.get(
        path,
        queryParameters: queryParameter,
        cancelToken: allowDuplicateRequest ? null : CancelToken(),
      );
    } on DioException{
      return null;
    }
  }

  Future<Response?> post({
    required String path,
    Map<String, dynamic>? data,
    bool allowDuplicateRequest = true,
    Map<String, dynamic>? queryParameter,
  }) async {
    try{
      return await dio.post(
        path,
        data: data,
        queryParameters: queryParameter,
        cancelToken: allowDuplicateRequest ? null : CancelToken(),
      );
    } on DioException{
      return null;
    }
  }

  Future<Response?> patch({
    required String path,
    Map<String, dynamic>? data,
    bool allowDuplicateRequest = true,
  }) async {
    try{
      return await dio.patch(
        path,
        data: data,
        cancelToken: allowDuplicateRequest ? null : CancelToken(),
      );
    } on DioException{
      return null;
    }
  }
}
