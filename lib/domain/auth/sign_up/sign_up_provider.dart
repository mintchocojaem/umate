import 'dart:async';

import 'package:danvery/domain/domain.dart';
import 'package:danvery/main.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes/route_path.dart';
import '../../../routes/router_provider.dart';

final isAgreePrivacyPolicyProvider =
  StateProvider.autoDispose<bool>((ref) => false);

final isAgreeThirdPartyProvider =
  StateProvider.autoDispose<bool>((ref) => false);

final signUpProvider =
    AsyncNotifierProvider<SignUpNotifier, SignUp?>(() => SignUpNotifier());

class SignUpNotifier extends AsyncNotifier<SignUp?> {

  String validNickname = "";
  String validPhoneNumber = "";

  Future<void> verifyStudent(String dkuStudentId, String dkuPassword) async {

    if (!ref.read(isAgreePrivacyPolicyProvider) || !ref.read(isAgreeThirdPartyProvider)) {
      OrbSnackBar.show(
        message: "개인정보 이용약관에 동의해주세요.",
        type: OrbSnackBarType.warning,
      );
      return;
    }
    state = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .verifyStudent(dkuStudentId, dkuPassword));
    if (!state.hasError) {
      ref.read(routerProvider).pushReplacement(RouteInfo.signUpCheckInfo.fullPath);
    }
  }

  Future<void> sendSMS( String phoneNumber) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .sendSMS(state.value!.signUpToken, phoneNumber));
    if (!result.hasError) {
      validPhoneNumber = phoneNumber;
      ref.read(routerProvider).pushReplacement(RouteInfo.signUpVerifySMS.fullPath);
    }
  }

  Future<void> resendSMS() async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .sendSMS(state.value!.signUpToken, validPhoneNumber));
    if (!result.hasError) {
    }
  }

  Future<void> verifySMS(String code) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .verifySMS(state.value!.signUpToken, code));
    if (!result.hasError) {
      ref.read(routerProvider).pushReplacement(RouteInfo.signUpNickname.fullPath);
    }
  }

  Future<void> verifyNickname(String nickname) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .validNickname(nickname));
    if (!result.hasError) {
      validNickname = nickname;
    }
  }

  Future<void> setNickname(String nickname) async{
    if(validNickname != nickname){
      OrbSnackBar.show(
        message: "닉네임 중복확인을 해주세요.",
        type: OrbSnackBarType.warning,
      );
      return;
    }
    ref.read(routerProvider).pushReplacement(RouteInfo.signUpPassword.fullPath);
  }

  Future<void> signUp(String password) async {
    final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
        .read(authRepositoryProvider)
        .signUp(state.value!.signUpToken, validNickname, password));
    if(!result.hasError){
      ref.read(routerProvider).pushReplacement(RouteInfo.signUpComplete.fullPath);
    }
  }

  @override
  FutureOr<SignUp?> build() {
    // TODO: implement build
    return state.value;
  }
}
