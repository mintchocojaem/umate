import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../services/network/network_client_service.dart';
import 'app_exception.dart';

class RemoteDataSource {
  final NetworkClientService networkClientService;

  RemoteDataSource({required this.networkClientService});

  Future<T> request<T, L>({
    required String path,
    required RequestType method,
    Map<String, dynamic>? headers,
   dynamic data,
    Map<String, dynamic>? queryParameters,
    required L Function(Map<String, dynamic> json) fromJson,
    List<String> deepToJsonByKeys = const [],
    CancelToken? cancelToken,
  }) async {

    try {
      final response = await networkClientService.request(
        path: path,
        method: method,
        headers: headers,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

      var responseJson = response.data;
      for (String key in deepToJsonByKeys) {
        responseJson = responseJson[key];
      }

      return responseJson is List<dynamic>
          ? responseJson.map((json) => fromJson(json)).toList() as T
          : fromJson(responseJson) as T;

    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('RemoteDataSource > message : $error, stackTrace : $stackTrace');
      }
      throw AppError(
        stackTrace: stackTrace,
      );
    }
  }
}
