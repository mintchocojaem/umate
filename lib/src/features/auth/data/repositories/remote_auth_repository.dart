import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final remoteAuthRepositoryProvider = Provider.autoDispose<AuthRepository>((ref) {
  return AuthRepository(remoteAuthApi: ref.watch(remoteAuthApiProvider));
});

class AuthRepository {
  final RemoteAuthApi remoteAuthApi;

  AuthRepository({
    required this.remoteAuthApi,
  });

  Future<TokenModel> login({
    required String studentId,
    required String password,
  }) async {
    return await remoteAuthApi.login(
      studentId: studentId,
      password: password,
    );
  }


  Future<SignUpModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return await remoteAuthApi.verifyStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
  }

  Future<bool> sendSMS({
    required String phoneNumber,
    required String signUpToken,
  }) async {
    return await remoteAuthApi.sendSMS(
      phoneNumber: phoneNumber,
      signUpToken: signUpToken,
    );
  }

  Future<bool> verifySMS({
    required String signUpToken,
    required String code,
  }) async {
    return await remoteAuthApi.verifySMS(
      signUpToken: signUpToken,
      code: code,
    );
  }

  Future<bool> validNickname({required String nickname}) async {
    return await remoteAuthApi.validNickname(
      nickname: nickname,
    );
  }

  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    return await remoteAuthApi.signUp(
      signUpToken: signUpToken,
      nickname: nickname,
      password: password,
    );
  }
}
