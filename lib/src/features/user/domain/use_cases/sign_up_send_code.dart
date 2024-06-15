import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

final signUpSendCodeProvider = Provider.autoDispose<SignUpSendCode>(
  (ref) => SignUpSendCode(
    authRepository: ref.watch(authRemoteRepositoryProvider),
  ),
);

class SignUpSendCodeParams extends UseCaseParams {
  final String signUpToken;
  final String phoneNumber;

  const SignUpSendCodeParams({
    required this.signUpToken,
    required this.phoneNumber,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [signUpToken, phoneNumber];
}

class SignUpSendCode extends UseCase<bool, SignUpSendCodeParams> {
  final AuthRemoteRepository authRepository;

  SignUpSendCode({
    required this.authRepository,
  });

  @override
  Future<bool> call(SignUpSendCodeParams params) async {
    // TODO: implement call
    if (params.phoneNumber.isEmpty) {
      throw AppError(
        message: '전화번호를 입력해주세요.',
        stackTrace: StackTrace.current,
      );
    }

    return await authRepository.signUpSendCode(
      signUpToken: params.signUpToken,
      phoneNumber: params.phoneNumber,
    );
  }
}
