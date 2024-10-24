import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/models/user_info.dart';
import '../../../domain/use_cases/user_use_cases.dart';
import '../../login/providers/login_token_provider.dart';

part 'user_info_provider.g.dart';

@riverpod
class UserInfoNotifier extends _$UserInfoNotifier {
  Future<UserInfo> _fetch() {
    return ref.read(userUseCasesProvider).getUserInfo();
  }

  @override
  FutureOr<UserInfo> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<void> deleteUser() async {
    final result = await AsyncValue.guard(
      () => ref.read(userUseCasesProvider).deleteUser(),
    );

    result.whenOrNull(
      data: (_) {
        ref.read(loginTokenNotifierProvider.notifier).logout();
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );
  }
}
