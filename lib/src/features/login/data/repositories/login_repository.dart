import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final loginRepositoryProvider = Provider.autoDispose<LoginRepository>((ref) {
  return LoginRepository(loginApi: ref.watch(loginApiProvider));
});

class LoginRepository {
  final LoginApi _loginApi;

  LoginRepository({
    required LoginApi loginApi,
  }) : _loginApi = loginApi;

  Future<TokenModel> login({
    required String studentId,
    required String password,
  }) async {
    return await _loginApi.login(
      studentId: studentId,
      password: password,
    );
  }
}
