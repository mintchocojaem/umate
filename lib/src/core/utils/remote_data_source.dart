import 'package:danvery/src/core/utils/app_exception.dart';
import 'package:flutter/foundation.dart';

import '../services/network/network_client_service.dart';

class RemoteDataSource {
  final NetworkClientService networkClientService;

  RemoteDataSource({required this.networkClientService});

  Future<T> request<T>({
    required String path,
    required RequestType method,
    Map<String, dynamic>? data,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final response = await networkClientService.request(
        path: path,
        method: method,
        data: data,
      );
      return fromJson(response.data);
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
