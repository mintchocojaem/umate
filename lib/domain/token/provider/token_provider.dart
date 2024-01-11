import 'dart:async';

import 'package:danvery/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repository/auth_repository.dart';

final tokenProvider = AsyncNotifierProvider<TokenNotifier, TokenModel>(
  () => TokenNotifier(),
);

class TokenNotifier extends AsyncNotifier<TokenModel> {
  Future<void> login(String studentId, String password) async {
    final token = ref.read(authRepositoryProvider).login(studentId, password);

    state = await AsyncValue.guard(() async {
      return await token;
    });
  }

  @override
  FutureOr<TokenModel> build() async {
    // TODO: implement build
    return await future;
  }
}
