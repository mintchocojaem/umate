import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth_dependency_injections.dart';
import '../../../domain/use_cases/sign_up_compelete_use_case.dart';
import '../states/sign_up_complete_state.dart';

class SignUpCompleteNotifier extends AutoDisposeNotifier<SignUpCompleteState> {

  @override
  SignUpCompleteState build() {
    // TODO: implement build
    return const SignUpCompleteInitial();
  }

  Future<void> signUpComplete({
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    state = const SignUpCompleteLoading();

    final result = await ref.read(signUpCompleteUseCaseProvider)(
      SignUpCompleteParams(
        signUpToken: signUpToken,
        nickname: nickname,
        password: password,
      ),
    );

    state = result.fold(
      (success) => const SignUpCompleteSuccess(),
      (failure) => SignUpCompleteFailure(
        exception: failure,
      ),
    );
  }

}