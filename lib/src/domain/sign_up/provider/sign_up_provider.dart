import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/data.dart';
import '../../domain.dart';

final signUpProvider =
    AsyncNotifierProvider.autoDispose<SignUpNotifier, SignUpModel>(
  () => SignUpNotifier(),
);

class SignUpNotifier extends AutoDisposeAsyncNotifier<SignUpModel> {
  late AuthRepository _authRepository;

  @override
  FutureOr<SignUpModel> build() {
    // TODO: implement build
    _authRepository = ref.watch(authRepositoryProvider);
    return future;
  }

  Future<void> verifyStudent(
    CancelToken? cancelToken, {
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    state = await AsyncValue.guard(
      () async {
        return await _authRepository.verifyStudent(
          cancelToken,
          dkuStudentId: dkuStudentId,
          dkuPassword: dkuPassword,
        );
      },
    );
  }

  Future<void> sendSMS(
    CancelToken? cancelToken, {
    required String phoneNumber,
  }) async {
    try {
      final signUpModel = await future;
      await _authRepository.sendSMS(
        cancelToken,
        signUpToken: signUpModel.signupToken,
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      // print(e);
    }
  }

  Future<void> verifySMS(
    CancelToken? cancelToken, {
    required String code,
  }) async {
    try {
      final signUpModel = await future;
      await _authRepository.verifySMS(
        cancelToken,
        signUpToken: signUpModel.signupToken,
        code: code,
      );
    } catch (e) {
      // print(e);
    }
  }
}
