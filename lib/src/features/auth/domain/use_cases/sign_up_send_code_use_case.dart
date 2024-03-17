import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

final signUpSendCodeUseCaseProvider =
    Provider.autoDispose<SignUpSendCodeUseCase>(
  (ref) => SignUpSendCodeUseCase(
    authRepository: ref.read(authRepositoryImplProvider),
  ),
);

class SignUpSendCodeParams {
  final String signUpToken;
  final String phoneNumber;

  const SignUpSendCodeParams({
    required this.signUpToken,
    required this.phoneNumber,
  });
}

class SignUpSendCodeUseCase extends UseCase<bool, SignUpSendCodeParams> {
  final AuthRepository authRepository;

  SignUpSendCodeUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> execute(SignUpSendCodeParams params) async {
    // TODO: implement execute
    return await authRepository.signUpSendCode(
      signUpToken: params.signUpToken,
      phoneNumber: params.phoneNumber,
    );
  }
}
