import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

final signUpCompleteUseCaseProvider =
    Provider.autoDispose<SignUpCompleteUseCase>(
  (ref) => SignUpCompleteUseCase(
    authRepository: ref.read(authRepositoryImplProvider),
  ),
);

class SignUpCompleteParams {
  final String signUpToken;
  final String nickname;
  final String password;

  const SignUpCompleteParams({
    required this.signUpToken,
    required this.nickname,
    required this.password,
  });
}

class SignUpCompleteUseCase extends UseCase<bool, SignUpCompleteParams> {
  final AuthRepository authRepository;

  SignUpCompleteUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> execute(SignUpCompleteParams params) async {
    // TODO: implement execute
    return await authRepository.signUpComplete(
      signUpToken: params.signUpToken,
      nickname: params.nickname,
      password: params.password,
    );
  }
}
