import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../data.dart';

final authApiProvider = Provider.autoDispose<AuthApi>(
  (ref) {
    return AuthApi(
      dioClient: ref.watch(dioClientProvider),
    );
  },
);

class AuthApi {
  final DioClient _dioClient;

  AuthApi({required DioClient dioClient}) : _dioClient = dioClient;

  Future<SignUpModel> verifyStudent(
    CancelToken? cancelToken, {
    required String studentId,
    required String studentPassword,
  }) async {
    final response = await _dioClient.dio.post(
      '/user/dku/verify',
      data: {
        'dkuStudentId': studentId,
        'dkuPassword': studentPassword,
      },
      cancelToken: cancelToken,
    );
    return SignUpModel.fromJson(response.data);
  }
}
