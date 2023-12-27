import 'package:dio/dio.dart';


abstract base class Repository {
  final Dio _dio;

  Repository(this._dio);

  Future<Response?> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    bool allowDuplicateRequest = true,
  }) async {
    try{
      return await _dio.get(
        path,
        queryParameters: queryParameters,
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
    Map<String, dynamic>? queryParameters,
  }) async {
    try{
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
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
      return await _dio.patch(
        path,
        data: data,
        cancelToken: allowDuplicateRequest ? null : CancelToken(),
      );
    } on DioException{
      return null;
    }
  }
}
