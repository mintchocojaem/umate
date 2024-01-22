import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/data.dart';
import '../../../../domain/domain.dart';

final signUpProvider =
    AsyncNotifierProvider.autoDispose<SignUpNotifier, SignUpEntity>(() {
  return SignUpNotifier();
});

class SignUpNotifier extends AutoDisposeAsyncNotifier<SignUpEntity> {
  late final SignUpRepository _signUpRepository;
  late final KeepAliveLink _link;

  @override
  FutureOr<SignUpEntity> build() {
    // TODO: implement build
    _signUpRepository = ref.watch(signUpRepositoryProvider);
    return future;
  }

  Future<void> verifyStudent(
    CancelToken? cancelToken, {
    required String studentId,
    required String studentPassword,
  }) async {

    _link = ref.keepAlive();

    final response = await AsyncValue.guard(
      () async => await _signUpRepository.verifyStudent(
        cancelToken,
        studentId: studentId,
        studentPassword: studentPassword,
      ),
    );

    state = response;

    if (state.hasError) {
      _link.close();
    }
  }
}
