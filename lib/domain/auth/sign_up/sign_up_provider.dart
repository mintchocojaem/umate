import 'dart:async';

import 'package:danvery/domain/auth/auth.dart';
import 'package:danvery/main.dart';
import 'package:danvery/modules/orb/components/snack_bar/orb_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes/route_name.dart';
import '../../../routes/router_provider.dart';

final signUpProvider =
    AsyncNotifierProvider<SignUpNotifier, SignUp?>(() => SignUpNotifier());

class SignUpNotifier extends AsyncNotifier<SignUp?> {

  bool isSentSMS = false;
  bool isVerifiedSMS = false;
  bool isValidNickname = false;

  Future<void> verifyStudent(String dkuStudentId, String dkuPassword) async {

    if (!ref.read(isAgreeAllProvider)) {
      OrbSnackBar.show(
        context: scaffoldMessengerKey.currentContext!,
        message: "개인정보 이용약관에 동의해주세요.",
        type: OrbSnackBarType.warning,
      );
      return;
    }

    state = const AsyncValue.loading();

    final AsyncValue<SignUp?> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .verifyStudent(dkuStudentId, dkuPassword));
    state = result;
    if (result.value != null) {
      ref.read(routerProvider).pushReplacement(RouteName.signUpCheckInfo);
    }
  }

  Future<void> sendSMS(String signUpToken, String phoneNumber) async {
    state = const AsyncValue.loading();
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .sendSMS(signUpToken, phoneNumber));
    if (result.value!) {
      isSentSMS = true;
      ref.read(routerProvider).pushReplacement(RouteName.signUpVerifySMS);
    }
  }

  Future<void> verifySMS(String signUpToken, String code) async {
    state = const AsyncValue.loading();
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .verifySMS(signUpToken, code));
    if (result.value!) {
      isVerifiedSMS = true;
      ref.read(routerProvider).pushReplacement(RouteName.signUpNickName);
    }
  }

  Future<void> verifyNickname(String nickname) async {
    state = const AsyncValue.loading();
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .validNickname(nickname));
    if (result.value!) {
      ref.read(signUpValidNicknameProvider.notifier).state = nickname;
      isValidNickname = true;
    }
  }

  Future<void> setValidNickname(String nickname) async{
    if( ref.read(signUpValidNicknameProvider.notifier).state != nickname){
      OrbSnackBar.show(
        context: scaffoldMessengerKey.currentContext!,
        message: "닉네임 중복확인을 해주세요.",
        type: OrbSnackBarType.warning,
      );
      return;
    }
    ref.read(routerProvider).pushReplacement(RouteName.signUpPassword);
  }

  Future<void> signUp(
      String signUpToken, String nickname, String password) async {

    state = const AsyncValue.loading();
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .signUp(signUpToken, nickname, password));
    if(result.value!){
      ref.read(routerProvider).pushReplacement(RouteName.signUpComplete);
    }
  }

  @override
  FutureOr<SignUp?> build() {
    // TODO: implement build
    return null;
  }
}
