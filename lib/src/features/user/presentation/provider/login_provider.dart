import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/token.dart';
import '../../domain/use_case/user_login.dart';

final loginProvider = AsyncNotifierProvider<LoginNotifier, Token?>(
  () => LoginNotifier(),
);

class LoginNotifier extends AsyncNotifier<Token?> {
  @override
  FutureOr<Token?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> login({
    required String studentId,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result = await ref.read(userLoginProvider)(
      UserLoginParams(
        studentId: studentId,
        password: password,
      ),
    );

    state = result.fold(
      (success) => AsyncData(success),
      (failure) => AsyncError(failure.message, failure.stackTrace),
    );
  }
}
