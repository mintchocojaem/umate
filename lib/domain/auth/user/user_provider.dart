import 'dart:async';

import 'package:danvery/domain/auth/auth.dart';
import 'package:danvery/routes/route_name.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    AsyncNotifierProvider<UserNotifier, User?>(() => UserNotifier());

class UserNotifier extends AsyncNotifier<User?> {

  String? resetPasswordToken;

  Future<void> getUser(String accessToken) async {
    final AsyncValue<User?> user = await AsyncValue.guard(() async =>
        await ref.read(authRepositoryProvider).getUser(accessToken));
    state = user;
  }

  Future<void> findUserId(String phoneNumber) async{
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .findUserId(phoneNumber));
    if(result.value!){
      ref.read(routerProvider).pushReplacement(RouteName.findUserIdComplete);
    }
  }

  Future<void> sendSMStoResetPassword(String phoneNumber) async{
    final AsyncValue<String?> result =
    await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .sendSMStoResetPassword(phoneNumber));
    if(result.value != null){
      resetPasswordToken = result.value;
      ref.read(routerProvider).pushReplacement(RouteName.verifySMStoResetPassword);
    }
  }

  Future<void> verifySMStoResetPassword(String code) async{
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .verifySMStoResetPassword(resetPasswordToken!, code));
    if(result.value!){
      ref.read(routerProvider).pushReplacement(RouteName.resetPassword);
    }
  }

  Future<void> resetPassword(String code) async{
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .resetPassword(resetPasswordToken!, code));
    if(result.value!){
      ref.read(routerProvider).pushReplacement(RouteName.resetPasswordComplete);
    }
  }

  @override
  FutureOr<User?> build() {
    // TODO: implement build
    return null;
  }
}
