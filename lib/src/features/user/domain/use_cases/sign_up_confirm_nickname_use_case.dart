
import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/use_case.dart';
import 'sign_up_verify_nickname_use_case.dart';

class SignUpConfirmNicknameParams {
  final String verifiedNickname;
  final String currentNickname;

  const SignUpConfirmNicknameParams({
    required this.verifiedNickname,
    required this.currentNickname,
  });
}

class SignUpConfirmNicknameUseCase
    extends UseCase<bool, SignUpConfirmNicknameParams> {
  final SignUpVerifyNicknameUseCase signUpVerifyNicknameUseCase;

  SignUpConfirmNicknameUseCase({
    required this.signUpVerifyNicknameUseCase,
  });

  @override
  Future<bool> execute(SignUpConfirmNicknameParams params) async {
    // TODO: implement execute

    if (params.verifiedNickname != params.currentNickname) {
      throw AppWarning(
        message: '닉네임 중복을 확인해주세요',
        stackTrace: StackTrace.current,
      );
    }

    return await signUpVerifyNicknameUseCase.execute(
      SignUpVerifyNicknameParams(nickname: params.currentNickname),
    );
  }
}
