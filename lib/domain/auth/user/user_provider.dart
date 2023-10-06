import 'dart:async';

import 'package:danvery/domain/auth/auth.dart';
import 'package:danvery/routes/route_path.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    AsyncNotifierProvider<UserNotifier, User?>(() => UserNotifier());

class UserNotifier extends AsyncNotifier<User?> {

  String? resetPasswordToken;

  Future<void> getUser(String accessToken) async {
    state = await AsyncValue.guard(() async =>
        await ref.read(authRepositoryProvider).getUser(accessToken));
  }

  Future<void> findUserId(String phoneNumber) async{
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .findUserId(phoneNumber));
    if(!result.hasError){
      ref.read(routerProvider).pushReplacement(RouteInfo.findUserIdComplete.fullPath);
    }
  }

  Future<void> sendSMStoResetPassword(String phoneNumber) async{
    final AsyncValue<String?> result =
    await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .sendSMStoResetPassword(phoneNumber));
    if(!result.hasError){
      resetPasswordToken = result.value;
      ref.read(routerProvider).pushReplacement(RouteInfo.verifySMStoResetPassword.fullPath);
    }
  }

  Future<void> verifySMStoResetPassword(String code) async{
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .verifySMStoResetPassword(resetPasswordToken!, code));
    if(!result.hasError){
      ref.read(routerProvider).pushReplacement(RouteInfo.resetPassword.fullPath);
    }
  }

  Future<void> resetPassword(String code) async{
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .resetPassword(resetPasswordToken!, code));
    if(!result.hasError){
      ref.read(routerProvider).pushReplacement(RouteInfo.resetPasswordComplete.fullPath);
    }
  }

  @override
  FutureOr<User?> build() {
    // TODO: implement build
    return state.value;
  }
}
