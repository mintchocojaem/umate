import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/user/domain/use_cases/login.dart';

import '../../data/repositories/auth_local_repository.dart';
import '../../domain/models/login_token.dart';
import '../../domain/use_cases/reissue_login_token.dart';

final loginTokenProvider =
    AsyncNotifierProvider<LoginTokenNotifier, LoginToken?>(
  () => LoginTokenNotifier(),
);

class LoginTokenNotifier extends AsyncNotifier<LoginToken?> {
  @override
  FutureOr<LoginToken?> build() {
    // TODO: implement build
    return _autoLogin();
  }

  Future<LoginToken?> _autoLogin() async {
    final savedToken = ref.read(authLocalRepositoryProvider).getLoginToken();

    if (savedToken == null) {
      return null;
    }

    state = AsyncData(savedToken);

    final result = await ref.read(
      reissueLoginTokenProvider(
        ReissueLoginTokenParams(refreshToken: savedToken.refreshToken),
      ),
    );

    return result;
  }

  Future<void> login({
    required String studentId,
    required String password,
  }) async {
    state = await AsyncValue.guard(
      () async => await ref.read(
        loginProvider(
          LoginParams(
            studentId: studentId,
            password: password,
          ),
        ),
      ),
    );
  }

  void logout() {
    state = const AsyncData(null);
    ref.read(authLocalRepositoryProvider).deleteLoginToken();
  }
}
