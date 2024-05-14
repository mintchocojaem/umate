import '../../../domain/models/user_info.dart';

sealed class UserInfoState {
  const UserInfoState();
}

class UserInfoInitialState extends UserInfoState {
  const UserInfoInitialState();
}

class UserInfoLoadingState extends UserInfoState {
  const UserInfoLoadingState();
}

class UserInfoSuccessState extends UserInfoState {
  final UserInfo userInfo;

  const UserInfoSuccessState({required this.userInfo});
}

class UserInfoDeletedState extends UserInfoState {
  const UserInfoDeletedState();
}

class UserInfoFailureState extends UserInfoState {
  final String message;

  const UserInfoFailureState({required this.message});
}