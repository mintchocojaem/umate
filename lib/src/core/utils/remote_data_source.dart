import 'package:flutter/foundation.dart';

import '../services/network/network_client_service.dart';
import 'app_exception.dart';

class RemoteDataSource {
  final NetworkClientService networkClientService;

  RemoteDataSource({required this.networkClientService});

  Future<T> request<T>({
    required String path,
    required RequestType method,
    Map<String, dynamic>? data,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await networkClientService.request(
        path: path,
        method: method,
        data: data,
      );
      return fromJson(response.data);
    } on AppException catch (error, stackTrace) {
      if (kDebugMode) {
        print(
            'RemoteDataSource > (Error) : Message = ${error.message}, StackTrace = $stackTrace');
      }
      throw AppException(
        message: error.message,
        stackTrace: stackTrace,
      );
    }
  }
}
