import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth_dependency_injections.dart';
import '../../../domain/use_cases/sign_up_confirm_nickname_use_case.dart';
import '../../../domain/use_cases/sign_up_verify_nickname_use_case.dart';
import '../states/sign_up_nickname_state.dart';

class SignUpNicknameNotifier extends AutoDisposeNotifier<SignUpNicknameState> {

  @override
  SignUpNicknameState build() {
    // TODO: implement build
    return const SignUpNicknameInitial();
  }

  Future<void> verifyNickname({
    required String nickname,
  }) async {
    state = const SignUpNicknameLoading();

    final result = await ref.read(signUpVerifyNicknameUseCaseProvider)(
      SignUpVerifyNicknameParams(
        nickname: nickname,
      ),
    );

    state = result.fold(
      (success) => SignUpNicknameVerified(
        verifiedNickname: nickname,
      ),
      (failure) => SignUpNicknameFailure(
        exception: failure,
      ),
    );
  }

  Future<void> confirmNickname({
    required String verifiedNickname,
    required String currentNickname,
  }) async {
    state = const SignUpNicknameLoading();

    final result = await ref.read(signUpConfirmNicknameUseCaseProvider)(
      SignUpConfirmNicknameParams(
        verifiedNickname: verifiedNickname,
        currentNickname: currentNickname,
      ),
    );

    state = result.fold(
      (success) => SignUpNicknameConfirmed(
        confirmedNickname: verifiedNickname,
      ),
      (failure) => SignUpNicknameFailure(
        exception: failure,
      ),
    );
  }

}
