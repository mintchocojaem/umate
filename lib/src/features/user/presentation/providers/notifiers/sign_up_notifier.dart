import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/use_cases/sign_up_send_code_use_case.dart';
import '../../../domain/use_cases/sign_up_use_case.dart';
import '../../../user_dependency_injections.dart';
import '../states/sign_up_state.dart';
import '../states/verify_student_state.dart';

class SignUpNotifier extends AutoDisposeNotifier<SignUpState> {
  @override
  SignUpState build() {
    // TODO: implement build
    return const SignUpInitialState();
  }

  Future<void> sendCode({
    required String phoneNumber,
  }) async {
    final signUpVerifyStudentState = ref.read(verifyStudentProvider);

    if (signUpVerifyStudentState is! VerifyStudentSuccessState) {
      state = const SignUpFailureState(message: '학생 인증을 먼저 진행해야 해요.');
      return;
    }

    if (signUpVerifyStudentState.signUpInfo == null) {
      state = const SignUpFailureState(message: '학생 인증을 먼저 진행해야 해요.');
      return;
    }

    state = const SignUpLoadingState();

    final result = await ref.read(signUpSendCodeUseCaseProvider)(
      SignUpSendCodeParams(
        signUpToken: signUpVerifyStudentState.signUpInfo!.signUpToken,
        phoneNumber: phoneNumber,
      ),
    );

    state = result.fold(
      (success) => const SignUpCodeSentState(),
      (failure) => SignUpFailureState(message: failure.message),
    );
  }

  Future<void> signUp({
    required String nickname,
    required String password,
    required String code,
  }) async {
    final signUpVerifyStudentState = ref.read(verifyStudentProvider);

    if (signUpVerifyStudentState is! VerifyStudentSuccessState) {
      state = const SignUpFailureState(message: '학생 인증을 먼저 진행해야 해요.');
      return;
    }

    if (signUpVerifyStudentState.signUpInfo == null) {
      state = const SignUpFailureState(message: '학생 인증을 먼저 진행해야 해요.');
      return;
    }

    state = const SignUpLoadingState();
    final result = await ref.read(signUpUseCaseProvider)(
      SignUpParams(
        signUpToken: signUpVerifyStudentState.signUpInfo!.signUpToken,
        nickname: nickname,
        password: password,
        code: code,
      ),
    );

    state = result.fold(
      (success) => SignUpSuccessState(
        studentName: signUpVerifyStudentState.signUpInfo!.student.studentName,
        studentId: signUpVerifyStudentState.signUpInfo!.student.studentId,
        password: password,
      ),
      (failure) => SignUpFailureState(message: failure.message),
    );
  }
}
