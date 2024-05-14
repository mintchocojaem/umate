import '../../../../core/utils/use_case.dart';
import '../repositories/user_repository.dart';

class ResetPasswordParams {
  final String token;
  final String newPassword;

  const ResetPasswordParams({
    required this.token,
    required this.newPassword,
  });
}

class ResetPasswordUseCase
    extends UseCase<bool, ResetPasswordParams> {
  final UserRepository userRepository;

  ResetPasswordUseCase({
    required this.userRepository,
  });

  @override
  Future<bool> execute(ResetPasswordParams params) async {
    // TODO: implement execute
    return await userRepository.resetPassword(
      token: params.token,
      password: params.newPassword,
    );
  }
}
