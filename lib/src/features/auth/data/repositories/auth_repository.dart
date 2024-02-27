import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/sign_up_info_model.dart';
import '../../domain/models/token_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

final authRepositoryImplProvider = Provider.autoDispose<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(authRemoteDataSource: ref.watch(authRemoteDataSourceProvider));
});

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  @override
  Future<TokenModel> login({
    required String studentId,
    required String password,
  }) async {
    final tokenEntity = await authRemoteDataSource.login(
      studentId: studentId,
      password: password,
    );
    return tokenEntity.mapToModel();
  }

  @override
  Future<SignUpInfoModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    final signUpInfoEntity = await authRemoteDataSource.verifyStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
    return signUpInfoEntity.mapToModel();
  }

  @override
  Future<bool> sendSignUpCode({
    required String phoneNumber,
    required String signUpToken,
  }) async {
    return await authRemoteDataSource.sendSignUpCode(
      phoneNumber: phoneNumber,
      signUpToken: signUpToken,
    );
  }

  @override
  Future<bool> verifySMS({
    required String signUpToken,
    required String code,
  }) async {
    return await authRemoteDataSource.verifySMS(
      signUpToken: signUpToken,
      code: code,
    );
  }

  @override
  Future<bool> validNickname({required String nickname}) async {
    return await authRemoteDataSource.validNickname(
      nickname: nickname,
    );
  }

  @override
  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    return await authRemoteDataSource.signUp(
      signUpToken: signUpToken,
      nickname: nickname,
      password: password,
    );
  }
}
