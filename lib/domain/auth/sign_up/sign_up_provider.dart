import 'dart:async';

import 'package:danvery/domain/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpProvider =
    AsyncNotifierProvider<SignUpNotifier, SignUp?>(() => SignUpNotifier());

class SignUpNotifier extends AsyncNotifier<SignUp?> {
  Future<void> verifyStudent(String dkuStudentId, String dkuPassword) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .verifyStudent(dkuStudentId, dkuPassword));
  }

  Future<void> sendSMS(String signUpToken, String phoneNumber) async {
    state = const AsyncValue.loading();
    await ref.read(authRepositoryProvider).sendSMS(signUpToken, phoneNumber);
    //todo 여기 나중에 쿨타임 타이머로 상태 바꿔서 60초 뒤에 다시 보낼 수 있게 하면 될듯?
    state = AsyncValue.data(state.value?.copyWith(isSentSMS: true));
  }

  Future<void> verifySMS(String signUpToken, String code) async {
    state = const AsyncValue.loading();
    await ref.read(authRepositoryProvider).verifySMS(signUpToken, code);
    state = AsyncValue.data(state.value?.copyWith(isVerified: true));
  }

  Future<void> signUp(
      String signUpToken, String nickname, String password) async {
    state = const AsyncValue.loading();
    await ref
        .read(authRepositoryProvider)
        .signUp(signUpToken, nickname, password);
    state = AsyncValue.data(state.value?.copyWith(isSignedUp: true));
  }

  @override
  FutureOr<SignUp?> build() {
    // TODO: implement build
    return null;
  }

}
