import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth_dependency_injections.dart';
import '../../../domain/use_cases/sign_up_verify_code_use_case.dart';
import '../states/sign_up_verify_code_state.dart';

class SignUpVerifyCodeNotifier
    extends AutoDisposeNotifier<SignUpVerifyCodeState> {
  @override
  SignUpVerifyCodeState build() {
    // TODO: implement build
    return const SignUpVerifyCodeInitial();
  }

  Future<void> verifyCode({
    required String signUpToken,
    required String code,
  }) async {
    final result = await ref.read(signUpVerifyCodeUseCaseProvider)(
      SignUpVerifyCodeParams(
        signUpToken: signUpToken,
        code: code,
      ),
    );

    state = result.fold(
      (success) => const SignUpVerifyCodeSuccess(),
      (failure) => SignUpVerifyCodeFailure(
        exception: failure,
      ),
    );
  }
}
