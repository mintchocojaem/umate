import 'package:danvery/src/features/auth/domain/domain.dart';
import 'package:danvery/src/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpApiProvider = Provider.autoDispose<SignUpApi>(
  (ref) {
    return SignUpApi(
      dioClient: ref.watch(dioClientProvider),
    );
  },
);

class SignUpApi {
  final DioClient _dioClient;

  SignUpApi({required DioClient dioClient}) : _dioClient = dioClient;

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
