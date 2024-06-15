import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

final resetPasswordProvider =
    Provider.autoDispose.family<Future<bool>, ResetPasswordParams>(
  (ref, params) => ResetPassword(
    authRemoteRepository: ref.watch(authRemoteRepositoryProvider),
  )(params),
);

class ResetPasswordParams extends UseCaseParams {
  final String token;
  final String code;
  final String newPassword;

  const ResetPasswordParams({
    required this.token,
    required this.code,
    required this.newPassword,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [token, code, newPassword];
}

class ResetPassword extends UseCase<bool, ResetPasswordParams> {
  final AuthRemoteRepository authRemoteRepository;

  ResetPassword({
    required this.authRemoteRepository,
  });

  @override
  Future<bool> call(ResetPasswordParams params) async {
    // TODO: implement call

    await authRemoteRepository.verifyPasswordResetCode(
      token: params.token,
      code: params.code,
    );

    return await authRemoteRepository.resetPassword(
      token: params.token,
      password: params.newPassword,
    );
  }
}
