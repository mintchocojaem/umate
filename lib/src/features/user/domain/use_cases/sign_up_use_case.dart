import '../../../../core/utils/use_case.dart';
import '../repositories/user_repository.dart';
import 'sign_up_verify_code_use_case.dart';
import 'sign_up_verify_nickname_use_case.dart';

class SignUpParams {
  final String signUpToken;
  final String nickname;
  final String password;
  final String code;

  const SignUpParams({
    required this.signUpToken,
    required this.nickname,
    required this.password,
    required this.code,
  });
}

class SignUpUseCase extends UseCase<bool, SignUpParams> {
  final UserRepository userRepository;
  final SignUpVerifyNicknameUseCase signUpVerifyNicknameUseCase;
  final SignUpVerifyCodeUseCase signUpVerifyCodeUseCase;

  SignUpUseCase({
    required this.userRepository,
    required this.signUpVerifyCodeUseCase,
    required this.signUpVerifyNicknameUseCase,
  });

  @override
  Future<bool> execute(SignUpParams params) async {
    // TODO: implement execute

    final bool isNicknameVerified = await signUpVerifyNicknameUseCase.execute(
      SignUpVerifyNicknameParams(
        nickname: params.nickname,
      ),
    );

    if (!isNicknameVerified) {
      return false;
    }

    final bool isCodeVerified = await signUpVerifyCodeUseCase.execute(
      SignUpVerifyCodeParams(
        signUpToken: params.signUpToken,
        code: params.code,
      ),
    );

    if (!isCodeVerified) {
      return false;
    }

    return await userRepository.signUp(
      signUpToken: params.signUpToken,
      nickname: params.nickname,
      password: params.password,
    );
  }
}
