import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/use_case.dart';
import '../../../user_dependency_injections.dart';
import '../states/user_info_state.dart';

class UserInfoNotifier extends AutoDisposeNotifier<UserInfoState> {
  @override
  UserInfoState build() {
    // TODO: implement build
    state = const UserInfoInitialState();
    getUserInfo();
    return state;
  }

  Future<void> getUserInfo() async {
    state = const UserInfoLoadingState();

    final result = await ref.read(getUserInfoUseCaseProvider)(
      const NoParams(),
    );

    state = result.fold(
      (success) => UserInfoSuccessState(
        userInfo: success,
      ),
      (failure) => UserInfoFailureState(
        message: failure.message,
      ),
    );
  }

  Future<void> deleteUser() async {
    state = const UserInfoLoadingState();

    final result = await ref.read(deleteUserUseCaseProvider)(
      const NoParams(),
    );

    state = result.fold(
      (success) => const UserInfoDeletedState(),
      (failure) => UserInfoFailureState(
        message: failure.message,
      ),
    );
  }
}
