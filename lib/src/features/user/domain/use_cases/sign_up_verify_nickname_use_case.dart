import '../../../../core/utils/use_case.dart';
import '../repositories/user_repository.dart';

class SignUpVerifyNicknameParams {
  final String nickname;

  const SignUpVerifyNicknameParams({
    required this.nickname,
  });
}

class SignUpVerifyNicknameUseCase
    extends UseCase<bool, SignUpVerifyNicknameParams> {
  final UserRepository userRepository;

  SignUpVerifyNicknameUseCase({
    required this.userRepository,
  });

  @override
  Future<bool> execute(SignUpVerifyNicknameParams params) async {
    // TODO: implement execute
    return await userRepository.signUpVerifyNickname(nickname: params.nickname);
  }
}
