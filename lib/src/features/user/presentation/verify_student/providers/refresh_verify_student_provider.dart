import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/use_cases/auth_use_cases.dart';

part 'refresh_verify_student_provider.g.dart';

@riverpod
class RefreshVerifyStudentNotifier extends _$RefreshVerifyStudentNotifier {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> refresh({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    state = await AsyncValue.guard(
      () async {
        return await ref.read(authUseCasesProvider).refeshExistingStudent(
              dkuStudentId: dkuStudentId,
              dkuPassword: dkuPassword,
            );
      },
    );
  }
}
