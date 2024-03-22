import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth_dependency_injections.dart';
import '../../../domain/use_cases/sign_up_send_code_use_case.dart';
import '../states/sign_up_send_code_state.dart';

class SignUpSendCodeNotifier extends AutoDisposeNotifier<SignUpSendCodeState> {

  @override
  SignUpSendCodeState build() {
    // TODO: implement build
    return const SignUpSendCodeInitial();
  }

  Future<void> sendCode({
    required String signUpToken,
    required String phoneNumber,
  }) async {
    final result = await ref.read(signUpSendCodeUseCaseProvider)(
      SignUpSendCodeParams(
        signUpToken: signUpToken,
        phoneNumber: phoneNumber,
      ),
    );

    state = result.fold(
      (success) => SignUpSendCodeSuccess(
        phoneNumber: phoneNumber,
      ),
      (failure) => SignUpSendCodeFailure(
        exception: failure,
      ),
    );
  }

}
