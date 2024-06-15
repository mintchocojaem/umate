import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';
import 'sign_up_verify_code.dart';
import 'verify_nickname.dart';

final signUpProvider = Provider.autoDispose(
  (ref) => SignUpUseCase(
    authRepository: ref.watch(authRemoteRepositoryProvider),
    signUpVerifyCode: ref.watch(signUpVerifyCodeProvider),
    verifyNickname: ref.watch(verifyNicknameProvider),
  ),
);

class SignUpParams extends UseCaseParams {
  final String signUpToken;
  final String nickname;
  final String password;
  final String code;

  const SignUpParams({
    required this.signUpToken,
    required this.nickname,
    required this.password,
    required this.code,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [signUpToken, nickname, password, code];
}

class SignUpUseCase extends UseCase<bool, SignUpParams> {
  final AuthRemoteRepository authRepository;
  final VerifyNickname verifyNickname;
  final SignUpVerifyCode signUpVerifyCode;

  SignUpUseCase({
    required this.authRepository,
    required this.signUpVerifyCode,
    required this.verifyNickname,
  });

  @override
  Future<bool> call(SignUpParams params) async {
    // TODO: implement call
    final isNicknameVerified = await verifyNickname(
      VerifyNicknameParams(
        nickname: params.nickname,
      ),
    );

    /*

    if (isNicknameVerified.isFailure) {
      throw isNicknameVerified.failure;
    }

    final isSignUpCodeVerified = await signUpVerifyCode(
      SignUpVerifyCodeParams(
        signUpToken: params.signUpToken,
        code: params.code,
      ),
    );

    if (isSignUpCodeVerified.isFailure) {
      throw isSignUpCodeVerified.failure;
    }

     */

    return await authRepository.signUp(
      signUpToken: params.signUpToken,
      nickname: params.nickname,
      password: params.password,
    );
  }

}
