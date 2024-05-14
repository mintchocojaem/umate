import '../../../../core/utils/use_case.dart';
import '../repositories/user_repository.dart';

class VerifyPasswordResetCodeParams {
  final String token;
  final String code;

  const VerifyPasswordResetCodeParams({
    required this.token,
    required this.code,
  });
}

class VerifyPasswordResetCodeUseCase
    extends UseCase<bool, VerifyPasswordResetCodeParams> {
  final UserRepository userRepository;

  VerifyPasswordResetCodeUseCase({
    required this.userRepository,
  });

  @override
  Future<bool> execute(VerifyPasswordResetCodeParams params) async {
    // TODO: implement execute
    return await userRepository.verifyPasswordResetCode(
      token: params.token,
      code: params.code,
    );
  }
}
