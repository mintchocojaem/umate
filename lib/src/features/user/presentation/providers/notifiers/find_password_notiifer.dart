import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/use_cases/reset_password_use_case.dart';
import '../../../domain/use_cases/send_password_reset_code_use_case.dart';
import '../../../domain/use_cases/verify_password_reset_code_use_case.dart';
import '../../../user_dependency_injections.dart';
import '../states/find_password_state.dart';

class FindPasswordNotifier extends AutoDisposeNotifier<FindPasswordState> {

  String? _token;

  @override
  FindPasswordState build() {
    // TODO: implement build
    return const FindPasswordInitialState();
  }

  Future<void> sendPasswordResetCode({required String phoneNumber}) async {
    state = const FindPasswordLoadingState();

    final result = await ref.read(sendPasswordResetCodeUseCaseProvider)(
      SendPasswordResetCodeParams(phoneNumber: phoneNumber),
    );

    result.fold(
      (success) {
        _token = success;
      },
      (failure) => state = FindPasswordFailureState(
        message: failure.message,
      ),
    );
  }

  Future<void> verifyPasswordResetCode({required String code}) async {

    if(_token == null){
      return;
    }

    final result = await ref.read(verifyPasswordResetCodeUseCaseProvider)(
      VerifyPasswordResetCodeParams(
        code: code,
        token: _token!,
      ),
    );

    result.fold(
      (success) => state = const FindPasswordResetCodeSuccessState(),
      (failure) => state = FindPasswordFailureState(
        message: failure.message,
      ),
    );
  }

  Future<void> resetPassword({
    required String newPassword,
  }) async {

    if(state is! FindPasswordResetCodeSuccessState || _token == null){
      return;
    }

    final result = await ref.read(resetPasswordUseCaseProvider)(
      ResetPasswordParams(
        token: _token!,
        newPassword: newPassword,
      ),
    );

    state = result.fold(
      (success) => const FindPasswordSuccessState(),
      (failure) => FindPasswordFailureState(
        message: failure.message,
      ),
    );
  }
}
