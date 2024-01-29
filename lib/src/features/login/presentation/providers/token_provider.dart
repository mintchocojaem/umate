import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final tokenProvider =
    AsyncNotifierProvider.autoDispose<TokenNotifier, TokenModel>(
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

    state = await AsyncValue.guard(
      () async => await _loginRepository.login(
        studentId: studentId,
        password: password,
      ),
    );

    if (state.hasError) {
      _link.close();
    }
  }
}
