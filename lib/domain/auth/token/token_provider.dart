import 'dart:async';

import 'package:danvery/domain/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider =
    AsyncNotifierProvider<TokenNotifier, Token?>(() => TokenNotifier());

class TokenNotifier extends AsyncNotifier<Token?> {

  Future<void> login(String studentId, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async =>
        await ref.read(authRepositoryProvider).login(studentId, password));
  }

  @override
  Token? build() {
    // TODO: implement build
    return null;
  }
}
