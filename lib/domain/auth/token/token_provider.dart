import 'dart:async';

import 'package:danvery/domain/domain.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:danvery/utils/shared_preference.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes/route_path.dart';

final tokenProvider =
    AsyncNotifierProvider<TokenNotifier, Token?>(() => TokenNotifier());

class TokenNotifier extends AsyncNotifier<Token?> {
  final SharedPreference _sharedPreference = SharedPreference();

  Future<void> login(String studentId, String password) async{
    state = await AsyncValue.guard(() async =>
    await ref.read(authRepositoryProvider).login(studentId, password));
    if(!state.hasError){
      _sharedPreference.token = state.value;
      ref.read(routerProvider).pushReplacement(RouteInfo.main.fullPath);
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
      //await reissueToken(token.accessToken, token.refreshToken);
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
    ref.listenSelf((previous, next) {
      /*
      if (previous != next) {
        _sharedPreference.token = next;
      }
       */
      if(previous?.value != null && next.value?.accessToken == null){
        ref.read(routerProvider).pushReplacement(RouteInfo.login.fullPath);
      }
    });

    return state.value;
  }
}
