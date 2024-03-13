import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class SignUpParams {
  final String signUpToken;
  final String nickname;
  final String password;

  SignUpParams({
    required this.signUpToken,
    required this.nickname,
    required this.password,
  });
}

class SignUpUseCase extends UseCase<bool, SignUpParams> {
  final AuthRepository authRepository;

  SignUpUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> call({
    required SignUpParams params,
  }) async {
    return await authRepository.signUp(
      signUpToken: params.signUpToken,
      nickname: params.nickname,
      password: params.password,
    );
  }
}