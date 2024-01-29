import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final signUpProvider =
    AsyncNotifierProvider.autoDispose<SignUpNotifier, SignUpModel>(
  () => SignUpNotifier(),
);

class SignUpNotifier extends AutoDisposeAsyncNotifier<SignUpModel> {
  late final SignUpRepository _signUpRepository;
  late final KeepAliveLink _link;

  @override
  FutureOr<SignUpModel> build() {
    // TODO: implement build
    _signUpRepository = ref.watch(signUpRepositoryProvider);
    return future;
  }

  Future<void> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    _link = ref.keepAlive();

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _signUpRepository.verifyStudent(
        dkuStudentId: dkuStudentId,
        dkuPassword: dkuPassword,
      ),
    );

    if (state.hasError) {
      _link.close();
    }
  }

  Future<bool> sendSMS(
    String signUpToken, {
    required String phoneNumber,
  }) async {
    if (state.hasError || !state.hasValue) {
      return false;
    }

    return await _signUpRepository.sendSMS(
      signUpToken: signUpToken,
      phoneNumber: phoneNumber,
    );
  }
}
