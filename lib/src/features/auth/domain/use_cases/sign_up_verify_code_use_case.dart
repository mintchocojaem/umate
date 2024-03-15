import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class SignUpVerifyCodeParams {
  final String signUpToken;
  final String code;

  SignUpVerifyCodeParams({
    required this.signUpToken,
    required this.code,
  });
}

class SignUpVerifyCodeUseCase extends UseCase<bool, SignUpVerifyCodeParams> {
  final AuthRepository authRepository;

  SignUpVerifyCodeUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> execute(SignUpVerifyCodeParams params) async {
    // TODO: implement execute
    return await authRepository.signUpVerifyCode(
      signUpToken: params.signUpToken,
      code: params.code,
    );
  }
}
