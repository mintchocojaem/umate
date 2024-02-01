import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
  return AuthRepository(authApi: ref.watch(authApiProvider));
});

class AuthRepository {
  final AuthApi _authApi;

  AuthRepository({
    required AuthApi authApi,
  }) : _authApi = authApi;

  Future<TokenModel> login({
    required String studentId,
    required String password,
  }) async {
    return await _authApi.login(
      studentId: studentId,
      password: password,
    );
  }


  Future<SignUpModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return await _authApi.verifyStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
  }

  Future<bool> sendSMS({
    required String phoneNumber,
    required String signUpToken,
  }) async {
    return await _authApi.sendSMS(
      phoneNumber: phoneNumber,
      signUpToken: signUpToken,
    );
  }

  Future<bool> verifySMS({
    required String signUpToken,
    required String code,
  }) async {
    return await _authApi.verifySMS(
      signUpToken: signUpToken,
      code: code,
    );
  }

  Future<bool> validNickname({required String nickname}) async {
    return await _authApi.validNickname(
      nickname: nickname,
    );
  }

  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    return await _authApi.signUp(
      signUpToken: signUpToken,
      nickname: nickname,
      password: password,
    );
  }
}
