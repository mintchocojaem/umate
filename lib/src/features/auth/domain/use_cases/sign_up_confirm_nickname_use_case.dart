import 'package:danvery/src/core/utils/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import 'sign_up_verify_nickname_use_case.dart';

final signUpConfirmNicknameUseCaseProvider =
    Provider.autoDispose<SignUpConfirmNicknameUseCase>(
  (ref) => SignUpConfirmNicknameUseCase(
    signUpVerifyNicknameUseCase: ref.read(signUpVerifyNicknameUseCaseProvider),
  ),
);

class SignUpConfirmNicknameParams {
  final String availableNickname;
  final String currentNickname;

  const SignUpConfirmNicknameParams({
    required this.availableNickname,
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

    if (params.availableNickname != params.currentNickname) {
      throw AppException(
        message: '닉네임 중복을 확인해주세요',
        stackTrace: StackTrace.current,
      );
    }

    return await signUpVerifyNicknameUseCase.execute(
      SignUpVerifyNicknameParams(nickname: params.currentNickname),
    );
  }
}
