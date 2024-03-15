import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class SignUpCompleteParams {
  final String signUpToken;
  final String nickname;
  final String password;

  SignUpCompleteParams({
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
  Future<bool> execute(SignUpCompleteParams params) async{
    // TODO: implement execute
    return await authRepository.signUpComplete(
      signUpToken: params.signUpToken,
      nickname: params.nickname,
      password: params.password,
    );
  }
}