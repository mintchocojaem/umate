import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class VerifySignUpCodeParams {
  final String signUpToken;
  final String code;

  VerifySignUpCodeParams({
    required this.signUpToken,
    required this.code,
  });
}

class VerifySignUpCodeUseCase extends UseCase<bool, VerifySignUpCodeParams> {
  final AuthRepository authRepository;

  VerifySignUpCodeUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> call({
    required VerifySignUpCodeParams params,
  }) async {
    return await authRepository.verifySignUpCode(
      signUpToken: params.signUpToken,
      code: params.code,
    );
  }
}
