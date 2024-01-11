import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/data.dart';
import '../../domain.dart';

final signUpProvider =
    AsyncNotifierProvider.autoDispose<SignUpNotifier, SignUpModel>(
  () => SignUpNotifier(),
);

class SignUpNotifier extends AutoDisposeAsyncNotifier<SignUpModel> {
  Future<void> verifyStudent(String dkuStudentId, String dkuPassword) async {
    final result = await ref
        .read(authRepositoryProvider)
        .verifyStudent(dkuStudentId, dkuPassword);

    state = await AsyncValue.guard(() async {
      return result;
    });
  }

  @override
  FutureOr<SignUpModel> build() {
    // TODO: implement build
    return future;
  }
}
