import '../models/sign_up_info_model.dart';
import '../models/token_model.dart';

abstract class AuthRepository {
  Future<TokenModel> login({
    required String studentId,
    required String password,
  });

  Future<SignUpInfoModel> signUpVerifyStudent({
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

  Future<bool> signUpComplete({
    required String signUpToken,
    required String nickname,
    required String password,
  });
}
