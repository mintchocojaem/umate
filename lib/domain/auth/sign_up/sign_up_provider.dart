import 'dart:async';

import 'package:danvery/domain/auth/auth.dart';
import 'package:danvery/main.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes/route_name.dart';
import '../../../routes/router_provider.dart';
import '../../../screens/screens.dart';

final signUpProvider =
    AsyncNotifierProvider<SignUpNotifier, SignUp?>(() => SignUpNotifier());

class SignUpNotifier extends AsyncNotifier<SignUp?> {

  bool isSentSMS = false;
  bool isVerifiedSMS = false;
  bool isValidNickname = false;

  Future<void> verifyStudent(String dkuStudentId, String dkuPassword) async {

    if (!ref.read(isAgreeAllProvider)) {
      OrbSnackBar.show(
        context: globalNavigatorKey.currentContext!,
        message: "개인정보 이용약관에 동의해주세요.",
        type: OrbSnackBarType.warning,
      );
      return;
    }
    state = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .verifyStudent(dkuStudentId, dkuPassword));
    if (!state.hasError) {
      ref.read(routerProvider).pushReplacement(RouteName.signUpCheckInfo);
    }
  }

  Future<void> sendSMS(String signUpToken, String phoneNumber) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .sendSMS(signUpToken, phoneNumber));
    if (!result.hasError) {
      isSentSMS = true;
      ref.read(routerProvider).pushReplacement(RouteName.signUpVerifySMS);
    }
  }

  Future<void> verifySMS(String signUpToken, String code) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .verifySMS(signUpToken, code));
    if (!result.hasError) {
      isVerifiedSMS = true;
      ref.read(routerProvider).pushReplacement(RouteName.signUpNickName);
    }
  }

  Future<void> verifyNickname(String nickname) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .validNickname(nickname));
    if (!result.hasError) {
      ref.read(signUpValidNicknameProvider.notifier).state = nickname;
      isValidNickname = true;
    }
  }

  Future<void> setValidNickname(String nickname) async{
    if( ref.read(signUpValidNicknameProvider.notifier).state != nickname){
      OrbSnackBar.show(
        context: globalNavigatorKey.currentContext!,
        message: "닉네임 중복확인을 해주세요.",
        type: OrbSnackBarType.warning,
      );
      return;
    }
    ref.read(routerProvider).pushReplacement(RouteName.signUpPassword);
  }

  Future<void> signUp(
      String signUpToken, String nickname, String password) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .signUp(signUpToken, nickname, password));
    if(!result.hasError){
      ref.read(routerProvider).pushReplacement(RouteName.signUpComplete);
    }
  }

  @override
  FutureOr<SignUp?> build() {
    // TODO: implement build
    return state.value;
  }
}
