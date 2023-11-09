import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/route_path.dart';
import '../../routes/router_provider.dart';
import '../domain.dart';

final findProvider = Provider<FindProvider>((ref) => FindProvider(ref));

class FindProvider{

  Ref ref;
  String resetPasswordToken = '';
  String validPhoneNumber = '';

  FindProvider(this.ref);

  Future<void> findUserId(String phoneNumber) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(findRepositoryProvider)
        .findUserId(phoneNumber));
    if(!result.hasError){
      validPhoneNumber = phoneNumber;
      ref.read(routerProvider).pushReplacement(RouteInfo.findUserIdComplete.fullPath);
    }
  }

  Future<void> resetPassword(String password) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(findRepositoryProvider)
        .resetPassword(resetPasswordToken, password));
    if(!result.hasError){
      ref.read(routerProvider).pushReplacement(RouteInfo.resetPasswordComplete.fullPath);
    }
  }

  Future<void> sendSMStoResetPassword(String phoneNumber) async {
    final AsyncValue<String?> result =
    await AsyncValue.guard(() async => await ref
        .read(findRepositoryProvider)
        .sendSMStoResetPassword(phoneNumber));
    if(!result.hasError){
      validPhoneNumber = phoneNumber;
      resetPasswordToken = result.value!;
      ref.read(routerProvider).pushReplacement(RouteInfo.verifySMStoResetPassword.fullPath);
    }
  }

  Future<void> resendSMStoResetPassword() async {
    final AsyncValue<String?> result =
    await AsyncValue.guard(() async => await ref
        .read(findRepositoryProvider)
        .sendSMStoResetPassword(validPhoneNumber));
    if(!result.hasError){
      resetPasswordToken = result.value!;
    }
  }

  Future<void> verifySMStoResetPassword(String smsCode) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(findRepositoryProvider)
        .verifySMStoResetPassword(resetPasswordToken, smsCode));
    if(!result.hasError){
      ref.read(routerProvider).pushReplacement(RouteInfo.resetPassword.fullPath);
    }
  }

}