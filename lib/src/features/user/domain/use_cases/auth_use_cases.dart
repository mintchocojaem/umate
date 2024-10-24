import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/auth_local_repository.dart';
import '../../data/repositories/auth_remote_repository.dart';
import '../models/login_token.dart';
import '../models/sign_up_info.dart';

part 'auth_use_cases.g.dart';

@riverpod
AuthUseCases authUseCases(AuthUseCasesRef ref) {
  return AuthUseCases(
    authRemoteRepository: ref.watch(authRemoteRepositoryProvider),
    authLocalRepository: ref.watch(authLocalRepositoryProvider),
  );
}

class AuthUseCases {
  final AuthRemoteRepository authRemoteRepository;
  final AuthLocalRepository authLocalRepository;

  AuthUseCases({
    required this.authRemoteRepository,
    required this.authLocalRepository,
  });

  Future<LoginToken> login({
    required String studentId,
    required String password,
  }) async {
    final loginToken = await authRemoteRepository.login(
      studentId: studentId,
      password: password,
    );

    authLocalRepository.saveLoginToken(
      token: loginToken,
    );
    return loginToken;
  }

  Future<bool> checkValidUser() async {
    return await authRemoteRepository.checkValidUser();
  }

  Future<LoginToken> reissueToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    return await authRemoteRepository.reissueToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<LoginToken?> autoLogin() async {
    final savedToken = authLocalRepository.getLoginToken();
    if (savedToken == null) {
      return null;
    }
    try {
      final loginToken = await reissueToken(
        accessToken: savedToken.accessToken,
        refreshToken: savedToken.refreshToken,
      );

      authLocalRepository.saveLoginToken(
        token: loginToken,
      );
      return loginToken;
    } catch (_) {
      authLocalRepository.deleteLoginToken();
      rethrow;
    }
  }

  void deleteSavedLoginToken() {
    authLocalRepository.deleteLoginToken();
  }

  Future<SignUpInfo> verifyNewStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return await authRemoteRepository.signUpVerifyStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
  }

  Future<bool> sendSignUpCode({
    required String signUpToken,
    required String phoneNumber,
  }) async {
    return await authRemoteRepository.signUpSendCode(
      signUpToken: signUpToken,
      phoneNumber: phoneNumber,
    );
  }

  Future<bool> verifySignUpCode({
    required String signUpToken,
    required String code,
  }) async {
    return await authRemoteRepository.signUpVerifyCode(
      signUpToken: signUpToken,
      code: code,
    );
  }

  Future<bool> verifyNickname({
    required String nickname,
  }) async {
    return await authRemoteRepository.verifyNickname(
      nickname: nickname,
    );
  }

  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    return await authRemoteRepository.signUp(
      signUpToken: signUpToken,
      nickname: nickname,
      password: password,
    );
  }

  Future<bool> sendStudentId({
    required String phoneNumber,
  }) async {
    return await authRemoteRepository.sendStudentId(
      phoneNumber: phoneNumber,
    );
  }

  Future<String> sendResetPasswordCode({
    required String phoneNumber,
  }) async {
    return await authRemoteRepository.sendPasswordResetCode(
      phoneNumber: phoneNumber,
    );
  }

  Future<bool> verifyResetPasswordCode({
    required String resetPasswordToken,
    required String code,
  }) async {
    return await authRemoteRepository.verifyPasswordResetCode(
      token: resetPasswordToken,
      code: code,
    );
  }

  Future<bool> resetPassword({
    required String resetPasswordToken,
    required String newPassword,
  }) async {
    return await authRemoteRepository.resetPassword(
      token: resetPasswordToken,
      password: newPassword,
    );
  }

  Future<bool> refreshExistingStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return await authRemoteRepository.refreshStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
  }
}
