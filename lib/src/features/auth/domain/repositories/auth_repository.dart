import '../models/sign_up_info_model.dart';
import '../models/token_model.dart';

abstract class AuthRepository {
  Future<TokenModel> login({
    required String studentId,
    required String password,
  });

  Future<SignUpInfoModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  });

  Future<bool> sendSignUpCode({
    required String phoneNumber,
    required String signUpToken,
  });

  Future<bool> verifySMS({
    required String signUpToken,
    required String code,
  });

  Future<bool> validNickname({
    required String nickname,
  });

  Future<bool> signUp({
    required String signUpToken,
    required String nickname,
    required String password,
  });
}
