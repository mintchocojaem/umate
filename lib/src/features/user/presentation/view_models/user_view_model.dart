import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/use_case.dart';

import '../../domain/models/user_info.dart';
import '../../domain/use_cases/delete_user.dart';
import '../../domain/use_cases/get_user_info.dart';

final userViewModelProvider =
    AsyncNotifierProvider.autoDispose<UserViewModel, UserInfo>(
  () => UserViewModel(),
);

class UserViewModel extends AutoDisposeAsyncNotifier<UserInfo> {
  @override
  FutureOr<UserInfo> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<UserInfo> _fetch() async {
    return await ref.read(
      getUserInfoProvider(
        const NoParams(),
      ),
    );
  }

  Future<void> deleteUser() async {
    final result = await AsyncValue.guard(
      () => ref.read(
        deleteUserProvider(
          const NoParams(),
        ),
      ),
    );

    result.whenOrNull(
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );
  }
}
