import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/sign_up_info.dart';
import '../../domain/use_cases/sign_up_verify_student.dart';

final signUpViewModelProvider =
    AsyncNotifierProvider.autoDispose<SignUpViewModel, SignUpInfo?>(
  () => SignUpViewModel(),
);

class SignUpViewModel extends AutoDisposeAsyncNotifier<SignUpInfo?> {
  @override
  FutureOr<SignUpInfo?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    state = await AsyncValue.guard(
      () => ref.read(
        signUpVerifyStudentProvider(
          SignUpVerifyStudentParams(
            dkuStudentId: dkuStudentId,
            dkuPassword: dkuPassword,
          ),
        ),
      ),
    );
  }
}
