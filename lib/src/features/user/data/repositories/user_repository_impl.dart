import '../../domain/models/sign_up_info.dart';
import '../../domain/models/token.dart';
import '../../domain/models/user_info.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/remote_user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteUserDataSource remoteUserDataSource;

  UserRepositoryImpl({required this.remoteUserDataSource});

  @override
  Future<Token> reissueToken({required String refreshToken}) async {
    final result = await remoteUserDataSource.reissueToken(
      refreshToken: refreshToken,
    );
    return result.mapToModel();
  }

  @override
  Future<Token> login({
    required String studentId,
    required String password,
  }) async {
    final result = await remoteUserDataSource.login(
      studentId: studentId,
      password: password,
    );
    return result.mapToModel();
  }

  @override
  Future<SignUpInfo> signUpVerifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    final result = await remoteUserDataSource.signUpVerifyStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
    return result.mapToModel();
  }

  @override
  Future<bool> refreshStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return await remoteUserDataSource.refreshStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
  }

  @override
  Future<bool> signUpSendCode({
    required String phoneNumber,
    required String signUpToken,
  }) async {
    final result = await remoteUserDataSource.signUpSendCode(
      phoneNumber: phoneNumber,
      signUpToken: signUpToken,
    );
    return result;
  }

  @override
  Future<bool> signUpVerifyCode({
    required String signUpToken,
    required String code,
  }) async {
    final result = await remoteUserDataSource.signUpVerifyCode(
      signUpToken: signUpToken,
      code: code,
    );
    return result;
  }

  @override
  Future<bool> signUpVerifyNickname({
    required String nickname,
  }) async {
    final result = await remoteUserDataSource.signUpVerifyNickname(
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
    final result = await remoteUserDataSource.signUp(
      signUpToken: signUpToken,
      nickname: nickname,
      password: password,
    );
    return result;
  }

  @override
  Future<UserInfo> getUserInfo() async {
    // TODO: implement getUserInfo
    final response = await remoteUserDataSource.getUserInfo();
    return response.mapToModel();
  }

  @override
  Future<bool> deleteUser() async {
    final response = await remoteUserDataSource.deleteUser();
    return response;
  }

  @override
  Future<String> sendPasswordResetCode({required String phoneNumber}) {
    // TODO: implement sendPasswordResetCode
    final response = remoteUserDataSource.sendPasswordResetCode(
      phoneNumber: phoneNumber,
    );
    return response;
  }

  @override
  Future<bool> verifyPasswordResetCode(
      {required String token, required String code}) {
    // TODO: implement verifyPasswordResetCode
    final response = remoteUserDataSource.verifyPasswordResetCode(
      token: token,
      code: code,
    );
    return response;
  }

  @override
  Future<bool> resetPassword(
      {required String token, required String password}) {
    // TODO: implement resetPassword
    final response = remoteUserDataSource.resetPassword(
      token: token,
      password: password,
    );
    return response;
  }

  @override
  Future<bool> sendStudentId({required String phoneNumber}) {
    // TODO: implement sendStudentId
    final response = remoteUserDataSource.sendStudentId(
      phoneNumber: phoneNumber,
    );
    return response;
  }
}
