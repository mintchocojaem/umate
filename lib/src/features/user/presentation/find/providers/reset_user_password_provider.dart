import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/use_cases/auth_use_cases.dart';

part 'reset_user_password_provider.g.dart';

enum ResetUserPasswordStep {
  initial,
  passwordCodeSent,
  passwordCodeVerified,
  passwordChanged,
}

class ResetUserPasswordState {
  final String token;
  final ResetUserPasswordStep step;

  ResetUserPasswordState({
    required this.token,
    required this.step,
  });

  factory ResetUserPasswordState.empty() {
    return ResetUserPasswordState(
      token: '',
      step: ResetUserPasswordStep.initial,
    );
  }

  ResetUserPasswordState copyWith({
    String? token,
    ResetUserPasswordStep? step,
  }) {
    return ResetUserPasswordState(
      token: token ?? this.token,
      step: step ?? this.step,
    );
  }
}

@riverpod
class ResetUserPasswordNotifier extends _$ResetUserPasswordNotifier {
  @override
  FutureOr<ResetUserPasswordState> build() {
    return ResetUserPasswordState.empty();
  }

  Future<void> sendResetPasswordCode({
    required String phoneNumber,
  }) async {
    state = await AsyncValue.guard(
      () async {
        final result =
            await ref.read(authUseCasesProvider).sendResetPasswordCode(
                  phoneNumber: phoneNumber,
                );
        return state.requireValue.copyWith(
          token: result,
          step: ResetUserPasswordStep.passwordCodeSent,
        );
      },
    );
  }

  Future<void> verifyResetPassword({
    required String code,
  }) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(authUseCasesProvider).verifyResetPasswordCode(
              resetPasswordToken: state.requireValue.token,
              code: code,
            );
        return state.requireValue.copyWith(
          step: ResetUserPasswordStep.passwordCodeVerified,
        );
      },
    );
  }

  Future<void> resetPassword({
    required String newPassword,
  }) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(authUseCasesProvider).resetPassword(
              resetPasswordToken: state.requireValue.token,
              newPassword: newPassword,
            );
        return state.requireValue.copyWith(
          step: ResetUserPasswordStep.passwordChanged,
        );
      },
    );
  }
}
