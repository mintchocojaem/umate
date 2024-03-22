import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth_dependency_injections.dart';
import '../../../domain/use_cases/sign_up_verify_student_use_case.dart';
import '../states/sign_up_verify_student_state.dart';

class SignUpVerifyStudentNotifier
    extends AutoDisposeNotifier<SignUpVerifyStudentState> {
  @override
  SignUpVerifyStudentState build() {
    // TODO: implement build
    return const SignUpVerifyStudentInitial();
  }

  Future<void> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
    required bool isAgreePolicy,
  }) async {
    state = const SignUpVerifyStudentLoading();

    final result = await ref.read(signUpVerifyStudentUseCaseProvider)(
      SignUpVerifyStudentParams(
        dkuStudentId: dkuStudentId,
        dkuPassword: dkuPassword,
        isAgreePolicy: isAgreePolicy,
      ),
    );

    state = result.fold(
      (success) => SignUpVerifyStudentSuccess(
        signUpInfo: success,
      ),
      (failure) => SignUpVerifyStudentFailure(
        exception: failure,
      ),
    );
  }
}
