import 'dart:async';

import 'package:danvery/src/features/auth/data/data.dart';
import 'package:danvery/src/features/auth/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final response = await AsyncValue.guard(
      () async => await _signUpRepository.verifyStudent(
        dkuStudentId: dkuStudentId,
        dkuPassword: dkuPassword,
      ),
    );

    state = response;

    if (state.hasError) {
      _link.close();
    }
  }
}
