import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/app_exception.dart';
import '../../../domain/use_cases/refresh_student_use_case.dart';
import '../../../domain/use_cases/sign_up_verify_student_use_case.dart';
import '../../../user_dependency_injections.dart';
import '../states/verify_student_state.dart';

class VerifyStudentNotifier extends AutoDisposeNotifier<VerifyStudentState> {
  @override
  VerifyStudentState build() {
    // TODO: implement build
    return const VerifyStudentInitialState();
  }

  Future<void> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
    required bool isAgreePolicy,
  }) async {
    state = const VerifyStudentLoadingState();

    final result = await ref.read(signUpVerifyStudentUseCaseProvider)(
      SignUpVerifyStudentParams(
        dkuStudentId: dkuStudentId,
        dkuPassword: dkuPassword,
        isAgreePolicy: isAgreePolicy,
      ),
    );

    state = result.fold(
      (success) => VerifyStudentSuccessState(
        signUpInfo: success,
      ),
      (failure) => failure is AppWarning
          ? VerifyStudentWarningState(
              message: failure.message,
            )
          : VerifyStudentFailureState(
              message: failure.message,
            ),
    );
  }

  Future<void> refreshStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    state = const VerifyStudentLoadingState();

    final result = await ref.read(refreshStudentUseCaseProvider)(
      RefreshStudentParams(
        dkuStudentId: dkuStudentId,
        dkuPassword: dkuPassword,
        isAgreePolicy: true,
      ),
    );

    state = result.fold(
      (success) => const VerifyStudentSuccessState(),
      (failure) => failure is AppWarning
          ? VerifyStudentWarningState(
              message: failure.message,
            )
          : VerifyStudentFailureState(
              message: failure.message,
            ),
    );
  }
}
