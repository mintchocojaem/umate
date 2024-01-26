import 'package:danvery/src/features/auth/data/data.dart';
import 'package:danvery/src/features/auth/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepositoryProvider = Provider.autoDispose<LoginRepository>((ref) {
  return LoginRepository(loginApi: ref.watch(loginApiProvider));
});

class LoginRepository {
  final LoginApi loginApi;

  LoginRepository({
    required this.loginApi,
  });

  Future<TokenModel> login({
    required String studentId,
    required String password,
  }) async {
    return await loginApi.login(
      studentId: studentId,
      password: password,
    );
  }
}