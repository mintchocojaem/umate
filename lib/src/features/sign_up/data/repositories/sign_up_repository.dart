import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final signUpRepositoryProvider = Provider.autoDispose<SignUpRepository>((ref) {
  return SignUpRepository(signUpApi: ref.watch(signUpApiProvider));
});

class SignUpRepository {
  final SignUpApi _signUpApi;

  SignUpRepository({
    required SignUpApi signUpApi,
  }) : _signUpApi = signUpApi;

  Future<SignUpModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return await _signUpApi.verifyStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
  }

  Future<bool> sendSMS({
    required String phoneNumber,
    required String signUpToken,
  }) async {
    return await _signUpApi.sendSMS(
      phoneNumber: phoneNumber,
      signUpToken: signUpToken,
    );
  }

  Future<bool> verifySMS({
    required String signUpToken,
    required String code,
  }) async {
    return await _signUpApi.verifySMS(
      signUpToken: signUpToken,
      code: code,
    );
  }

  Future<bool> validNickname({required String nickname}) async {
    return await _signUpApi.validNickname(
      nickname: nickname,
    );
  }

  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    return await _signUpApi.signUp(
      signUpToken: signUpToken,
      nickname: nickname,
      password: password,
    );
  }
}
