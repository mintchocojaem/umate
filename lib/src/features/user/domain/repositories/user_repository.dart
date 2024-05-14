import '../models/sign_up_info.dart';
import '../models/token.dart';
import '../models/user_info.dart';

abstract class UserRepository {

  Future<Token> reissueToken({
    required String refreshToken,
  });

  Future<Token> login({
    required String studentId,
    required String password,
  });

  Future<SignUpInfo> signUpVerifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  });

  Future<bool> refreshStudent({
    required String dkuStudentId,
    required String dkuPassword,
  });

  Future<bool> signUpSendCode({
    required String phoneNumber,
    required String signUpToken,
  });

  Future<bool> signUpVerifyCode({
    required String signUpToken,
    required String code,
  });

  Future<bool> signUpVerifyNickname({
    required String nickname,
  });

  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  });

  Future<bool> sendStudentId({
    required String phoneNumber,
  });

  Future<String> sendPasswordResetCode({
    required String phoneNumber,
  });

  Future<bool> verifyPasswordResetCode({
    required String token,
    required String code,
  });

  Future<bool> resetPassword({
    required String token,
    required String password,
  });

  Future<UserInfo> getUserInfo();

  Future<bool> deleteUser();
}
