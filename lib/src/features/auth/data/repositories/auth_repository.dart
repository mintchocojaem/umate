import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/sign_up_info_model.dart';
import '../../domain/models/token_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

final authRepositoryImplProvider =
    Provider.autoDispose<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(
      authRemoteDataSource: ref.watch(authRemoteDataSourceProvider));
});

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  @override
  Future<TokenModel> login({
    required String studentId,
    required String password,
  }) async {
    final result = await authRemoteDataSource.login(
      studentId: studentId,
      password: password,
    );
    return result.mapToModel();
  }

  @override
  Future<SignUpInfoModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    final result = await authRemoteDataSource.verifyStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
    return result.mapToModel();
  }

  @override
  Future<bool> sendSignUpCode({
    required String phoneNumber,
    required String signUpToken,
  }) async {
    final result = await authRemoteDataSource.sendSignUpCode(
      phoneNumber: phoneNumber,
      signUpToken: signUpToken,
    );
    return result;
  }

  @override
  Future<bool> verifySignUpCode({
    required String signUpToken,
    required String code,
  }) async {
    final result = await authRemoteDataSource.verifySignUpCode(
      signUpToken: signUpToken,
      code: code,
    );
    return result;
  }

  @override
  Future<bool> verifyNickname({
    required String nickname,
  }) async {
    final result = await authRemoteDataSource.verifyNickname(
      nickname: nickname,
    );
    return result;
  }

  @override
  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    final result = await authRemoteDataSource.signUp(
      signUpToken: signUpToken,
      nickname: nickname,
      password: password,
    );
    return result;
  }
}
