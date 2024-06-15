import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

final signUpVerifyCodeProvider = Provider.autoDispose.family<Future<bool>, SignUpVerifyCodeParams>(
  (ref, params) => SignUpVerifyCode(
    authRepository: ref.watch(authRemoteRepositoryProvider),
  )(params),
);

class SignUpVerifyCodeParams extends UseCaseParams {
  final String signUpToken;
  final String code;

  const SignUpVerifyCodeParams({
    required this.signUpToken,
    required this.code,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [signUpToken, code];
}

class SignUpVerifyCode extends UseCase<bool, SignUpVerifyCodeParams> {
  final AuthRemoteRepository authRepository;

  SignUpVerifyCode({
    required this.authRepository,
  });

  @override
  Future<bool> call(SignUpVerifyCodeParams params) async {
    // TODO: implement call
    return await authRepository.signUpVerifyCode(
      signUpToken: params.signUpToken,
      code: params.code,
    );
  }
}
