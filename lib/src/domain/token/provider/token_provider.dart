import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/auth_repository.dart';
import '../../domain.dart';

final tokenProvider = AsyncNotifierProvider.autoDispose<TokenNotifier, TokenModel>(
  () {
    return TokenNotifier();
  },
);

class TokenNotifier extends AutoDisposeAsyncNotifier<TokenModel> {

  late AuthRepository _authRepository;

  @override
  FutureOr<TokenModel> build() {
    // TODO: implement build
    _authRepository = ref.watch(authRepositoryProvider);
    return future;
  }

  Future<void> login(
    CancelToken? cancelToken, {
    required String studentId,
    required String password,
  }) async {
    state = await AsyncValue.guard(() async{
      return await _authRepository.login(
        cancelToken,
        studentId: studentId,
        password: password,
      );
    });
  }

}
