import 'package:danvery/src/features/auth/data/data.dart';
import 'package:danvery/src/features/auth/domain/domain.dart';
import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepositoryProvider = Provider.autoDispose<LoginRepository>((ref) {
  return LoginRepository(authDataSource: ref.watch(authApiProvider));
});

class LoginRepository {
  final AuthApi _authDataSource;

  LoginRepository({
    required AuthApi authDataSource,
  }) : _authDataSource = authDataSource;

  Future<TokenModel> login({
    required String studentId,
    required String password,
  }) async {
    return await _authDataSource.login(
      studentId: studentId,
      password: password,
    );
  }
}