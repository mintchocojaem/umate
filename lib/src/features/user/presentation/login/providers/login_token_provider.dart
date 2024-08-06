import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/models/login_token.dart';
import '../../../domain/use_cases/auth_use_cases.dart';

part 'login_token_provider.g.dart';

@Riverpod(keepAlive: true)
class LoginTokenNotifier extends _$LoginTokenNotifier {
  @override
  FutureOr<LoginToken?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> login({
    required String studentId,
    required String password,
  }) async {
    state = await AsyncValue.guard(
      () => ref.read(authUseCasesProvider).login(
            studentId: studentId,
            password: password,
          ),
    );
  }

  void logout() {
    state = const AsyncData(null);
    ref.read(authUseCasesProvider).deleteSavedLoginToken();
  }
}
