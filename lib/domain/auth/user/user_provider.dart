import 'dart:async';

import 'package:danvery/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    AsyncNotifierProvider<UserNotifier, User>(() => UserNotifier());

class UserNotifier extends AsyncNotifier<User> {

  //user이랑 find 부분 분리 -> 안그럼 find 기능 쓰려면 User 상태값이 존재해야 함

  Future<void> getUser() async {
    state = await AsyncValue.guard(() async =>
        await ref.read(authRepositoryProvider).getUser());
  }

  @override
  FutureOr<User> build() async{
    // TODO: implement build
    await getUser();
    return state.value!;
  }
}
