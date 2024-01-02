import 'package:danvery/domain/find/find_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/route_path.dart';
import '../../routes/router_provider.dart';
import '../domain.dart';

final findProvider = StateProvider.autoDispose((ref) => FindProvider(ref));

class FindProvider {
  final Ref ref;

  FindProvider(this.ref);

  Future<void> findUserId(String phoneNumber) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async =>
        await ref.read(findRepositoryProvider).findUserId(phoneNumber));
    if (!result.hasError) {
      ref
          .read(routerProvider)
          .pushReplacement(RouteInfo.findUserIdComplete.fullPath);
    }
  }

  Future<void> sendSMStoResetPassword(String phoneNumber) async {
    final AsyncValue<String?> result = await AsyncValue.guard(() async =>
        await ref
            .read(findRepositoryProvider)
            .sendSMStoResetPassword(phoneNumber));
    if (!result.hasError) {
      ref.read(routerProvider).pushReplacement(
            RouteInfo.verifySMStoResetPassword.fullPath,
            extra: FindInfo(
              phoneNumber: phoneNumber,
              resetPasswordToken: result.value!,
            ),
          );
    }
  }

  Future<String?> resendSMStoResetPassword(String phoneNumber) async {
    final AsyncValue<String?> result = await AsyncValue.guard(() async =>
        await ref
            .read(findRepositoryProvider)
            .sendSMStoResetPassword(phoneNumber));
    return result.value;
  }

  Future<void> verifySMStoResetPassword(
      String resetPasswordToken, String smsCode) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(findRepositoryProvider)
        .verifySMStoResetPassword(resetPasswordToken, smsCode));
    if (!result.hasError) {
      ref
          .read(routerProvider)
          .pushReplacement(RouteInfo.resetPassword.fullPath);
    }
  }

  Future<void> resetPassword(String resetPasswordToken, String password) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(findRepositoryProvider)
        .resetPassword(resetPasswordToken, password));
    if (!result.hasError) {
      ref
          .read(routerProvider)
          .pushReplacement(RouteInfo.resetPasswordComplete.fullPath);
    }
  }

}
