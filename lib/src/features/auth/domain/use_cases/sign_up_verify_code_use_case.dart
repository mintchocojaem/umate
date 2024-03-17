import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

final signUpVerifyCodeUseCaseProvider =
    Provider.autoDispose<SignUpVerifyCodeUseCase>(
  (ref) => SignUpVerifyCodeUseCase(
    authRepository: ref.read(authRepositoryImplProvider),
  ),
);

class SignUpVerifyCodeParams {
  final String signUpToken;
  final String code;

  const SignUpVerifyCodeParams({
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
