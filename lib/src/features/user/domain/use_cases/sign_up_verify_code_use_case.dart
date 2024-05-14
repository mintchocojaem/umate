import '../../../../core/utils/use_case.dart';
import '../repositories/user_repository.dart';

class SignUpVerifyCodeParams {
  final String signUpToken;
  final String code;

  const SignUpVerifyCodeParams({
    required this.signUpToken,
    required this.code,
  });
}

class SignUpVerifyCodeUseCase extends UseCase<bool, SignUpVerifyCodeParams> {
  final UserRepository userRepository;

  SignUpVerifyCodeUseCase({
    required this.userRepository,
  });

  @override
  Future<bool> execute(SignUpVerifyCodeParams params) async {
    // TODO: implement execute
    return await userRepository.signUpVerifyCode(
      signUpToken: params.signUpToken,
      code: params.code,
    );
  }
}
