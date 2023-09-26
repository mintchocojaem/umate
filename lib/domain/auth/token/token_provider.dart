import 'dart:async';

import 'package:danvery/domain/auth/auth.dart';
import 'package:danvery/utils/shared_preference.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider =
    AsyncNotifierProvider<TokenNotifier, Token?>(() => TokenNotifier());

class TokenNotifier extends AsyncNotifier<Token?> {
  final SharedPreference _sharedPreference = SharedPreference();

  Future<void> login(String studentId, String password) async{
    state = await AsyncValue.guard(() async =>
    await ref.read(authRepositoryProvider).login(studentId, password));
    if(!state.hasError){
      _sharedPreference.token = state.value;
    }
  }

  Future<void> reissueToken(String accessToken, String refreshToken) async {
    state = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .reissueToken(accessToken, refreshToken));
    if (!state.hasError) {
      _sharedPreference.token = state.value;
    }
  }

  Future<void> autoLogin() async {
    final Token? token = _sharedPreference.token;
    if (token != null) {
      //Todo accessToken 부분 나중에 수정해야함
      await reissueToken(token.accessToken, token.refreshToken);
    }
  }

  void logout() {
    state = const AsyncValue.data(null);
    _sharedPreference.token = null;
  }

  @override
  Future<Token?> build() async {
    // TODO: implement build
    //await autoLogin();
    //await login("12345678", "121212");
    return state.value;
  }
}
