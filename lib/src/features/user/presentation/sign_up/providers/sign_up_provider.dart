import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/models/sign_up_info.dart';
import '../../../domain/use_cases/auth_use_cases.dart';

part 'sign_up_provider.g.dart';

enum SignUpStep {
  initial,
  studentVerified,
  codeSent,
  codeVerified,
  signUpCompleted,
}

class SignUpState {
  final SignUpStep step;
  final SignUpInfo? signUpInfo;

  SignUpState({
    required this.step,
    this.signUpInfo,
  });

  factory SignUpState.empty() {
    return SignUpState(
      step: SignUpStep.initial,
      signUpInfo: null,
    );
  }

  SignUpState copyWith({
    SignUpStep? step,
    SignUpInfo? signUpInfo,
  }) {
    return SignUpState(
      step: step ?? this.step,
      signUpInfo: signUpInfo ?? this.signUpInfo,
    );
  }
}

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  @override
  FutureOr<SignUpState> build() {
    // TODO: implement build
    return SignUpState.empty();
  }

  Future<void> verifyNewStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    state = await AsyncValue.guard(() async {
      final result = await ref.read(authUseCasesProvider).verifyNewStudent(
            dkuStudentId: dkuStudentId,
            dkuPassword: dkuPassword,
          );

      return state.requireValue.copyWith(
        step: SignUpStep.studentVerified,
        signUpInfo: result,
      );
    });
  }

  Future<void> sendCode({
    required String phoneNumber,
  }) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(authUseCasesProvider).sendSignUpCode(
              phoneNumber: phoneNumber,
              signUpToken: state.requireValue.signUpInfo!.signupToken,
            );
        return state.requireValue.copyWith(
          step: SignUpStep.codeSent,
        );
      },
    );
  }

  Future<void> verifyCode({
    required String code,
  }) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(authUseCasesProvider).verifySignUpCode(
              code: code,
              signUpToken: state.requireValue.signUpInfo!.signupToken,
            );
        return state.requireValue.copyWith(
          step: SignUpStep.codeVerified,
        );
      },
    );
  }

  Future<void> signUp({
    required String nickname,
    required String password,
  }) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(authUseCasesProvider).signUp(
              nickname: nickname,
              password: password,
              signUpToken: state.requireValue.signUpInfo!.signupToken,
            );
        return state.requireValue.copyWith(
          step: SignUpStep.signUpCompleted,
        );
      },
    );
  }
}
