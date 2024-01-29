import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../features.dart';

final loginApiProvider = Provider.autoDispose<LoginApi>((ref) {
  return LoginApi(
    dioClient: ref.watch(dioClientProvider),
  );
});

class LoginApi {
  final DioClient _dioClient;

  LoginApi({required DioClient dioClient}) : _dioClient = dioClient;

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

}
