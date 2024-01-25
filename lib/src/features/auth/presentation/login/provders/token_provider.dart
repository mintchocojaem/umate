import 'dart:async';

import 'package:danvery/src/features/auth/data/data.dart';
import 'package:danvery/src/features/auth/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider = AsyncNotifierProvider.autoDispose<TokenNotifier, TokenModel>(
  () => TokenNotifier(),
);

class TokenNotifier extends AutoDisposeAsyncNotifier<TokenModel> {
  late final LoginRepository _loginRepository;
  late final KeepAliveLink _link;

  @override
  FutureOr<TokenModel> build() {
    _loginRepository = ref.watch(loginRepositoryProvider);
    return future;
  }

  Future<void> login({
    required String studentId,
    required String password,
  }) async {
    _link = ref.keepAlive();

    final response = await AsyncValue.guard(
      () async => await _loginRepository.login(
        studentId: studentId,
        password: password,
      ),
    );

    state = response;

    if (state.hasError) {
      _link.close();
    }
  }

}