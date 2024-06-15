import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

class ResetPasswordParams extends UseCaseParams {
  final String token;
  final String newPassword;

  const ResetPasswordParams({
    required this.token,
    required this.newPassword,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [token, newPassword];
}

class ResetPasswordUseCase extends UseCase<bool, ResetPasswordParams> {
  final AuthRemoteRepository authRemoteRepository;

  ResetPasswordUseCase({
    required this.authRemoteRepository,
  });

  @override
  Future<bool> call(ResetPasswordParams params) async {
    // TODO: implement call
    return await authRemoteRepository.resetPassword(
      token: params.token,
      password: params.newPassword,
    );
  }
}
