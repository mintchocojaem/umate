import 'dart:async';

import 'package:danvery/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    AsyncNotifierProvider<UserNotifier, User>(() => UserNotifier());

class UserNotifier extends AsyncNotifier<User> {

  //todo user이랑 find 부분 분리해야함

  Future<void> getUser() async {
    state = await AsyncValue.guard(() async =>
        await ref.read(authRepositoryProvider).getUser() as User);
  }

  @override
  FutureOr<User> build() async{
    // TODO: implement build
    await getUser();
    return state.value!;
  }
}
