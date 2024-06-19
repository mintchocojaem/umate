import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';
import 'sign_up_verify_code.dart';
import 'verify_nickname.dart';

final signUpProvider = Provider.autoDispose.family<Future<bool>, SignUpParams>(
  (ref, params) async {
    await ref.read(
      verifyNicknameProvider(
        VerifyNicknameParams(
          nickname: params.nickname,
        ),
      ),
    );
    await ref.read(
      signUpVerifyCodeProvider(
        SignUpVerifyCodeParams(
          signUpToken: params.signUpToken,
          code: params.code,
        ),
      ),
    );
    final authRepository = ref.watch(authRemoteRepositoryProvider);
    return SignUp(
      authRepository: authRepository,
    )(params);
  },
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

class SignUp extends UseCase<bool, SignUpParams> {
  final AuthRemoteRepository authRepository;

  SignUp({
    required this.authRepository,
  });

  @override
  Future<bool> call(SignUpParams params) async {
    // TODO: implement call

    return await authRepository.signUp(
      signUpToken: params.signUpToken,
      nickname: params.nickname,
      password: params.password,
    );
  }
}
