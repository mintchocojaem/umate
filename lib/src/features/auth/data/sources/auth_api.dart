import 'package:danvery/src/features/auth/domain/domain.dart';
import 'package:danvery/src/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<TokenModel> login({
    required String studentId,
    required String password,
  }) async {
    final response = await _dioClient.request(
      path: '/user/login',
      method: RequestType.post,
      data: {
        'studentId': studentId,
        'password': password,
      },
    );
    return TokenModel.fromJson(response.data);
  }

  Future<SignUpModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    final response = await _dioClient.request(
      path: '/user/dku/verify',
      method: RequestType.post,
      data: {
        'dkuStudentId': dkuStudentId,
        'dkuPassword': dkuPassword,
      },
    );
    return SignUpModel.fromJson(response.data);
  }
}
