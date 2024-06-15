import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/sign_up_info.dart';
import '../../domain/use_cases/sign_up_verify_student.dart';

final signUpInfoProvider =
    AsyncNotifierProvider.autoDispose<SignUpInfoNotifier, SignUpInfo?>(
  () => SignUpInfoNotifier(),
);

class SignUpInfoNotifier extends AutoDisposeAsyncNotifier<SignUpInfo?> {
  @override
  FutureOr<SignUpInfo?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
    required bool isAgreePolicy,
  }) async {
    state = const AsyncLoading();

    final result = await ref.read(signUpVerifyStudentProvider)(
      SignUpVerifyStudentParams(
        dkuStudentId: dkuStudentId,
        dkuPassword: dkuPassword,
        isAgreePolicy: isAgreePolicy,
      ),
    );

    /*
    result.fold(
      (success) {
        state = AsyncData(success);
      },
      (failure) {
        state = AsyncError(
          failure,
          StackTrace.current,
        );
      },
    );

     */
  }
}
