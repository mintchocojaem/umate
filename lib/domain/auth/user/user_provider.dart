import 'dart:async';

import 'package:danvery/domain/domain.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final profileEditNicknameProvider =
    StateProvider.autoDispose<String?>((ref) => ref.read(userProvider).value?.nickname);

final profileEditPhoneNumberProvider =
    StateProvider.autoDispose<String?>((ref) => ref.read(userProvider).value?.phoneNumber);


final profileEditableProvider = StateProvider.autoDispose<bool>((ref){
  final user = ref.watch(userProvider);
  final currentNickname = user.value?.nickname;
  final currentPhoneNumber = user.value?.phoneNumber;

  final nickname = ref.watch(profileEditNicknameProvider);
  final phoneNumber = ref.watch(profileEditPhoneNumberProvider);

  if(nickname == null || phoneNumber == null) return false;

  return (currentNickname != nickname) || (currentPhoneNumber != phoneNumber);
});

final userProvider =
    AsyncNotifierProvider<UserNotifier, User>(() => UserNotifier());

class UserNotifier extends AsyncNotifier<User> {
  //user이랑 find 부분 분리 -> 안그럼 find 기능 쓰려면 User 상태값이 존재해야 함

  Future<void> getUser() async {
    state = await AsyncValue.guard(
        () async => await ref.read(authRepositoryProvider).getUser());
  }

  Future<bool> validNickname(String nickname) async {
    final result = await AsyncValue.guard(() async =>
        await ref.read(authRepositoryProvider).validNickname(nickname));
    if (!result.hasError) {
      return true;
    }
    return false;
  }

  Future<void> changeNickname(String nickname) async {
    final result = await AsyncValue.guard(() async =>
        await ref.read(authRepositoryProvider).changeNickname(nickname));
    if (!result.hasError) {
      state = AsyncData(state.value!.copyWith(nickname: nickname));
      OrbSnackBar.show(
        message: '닉네임이 변경되었어요.',
        type: OrbSnackBarType.info,
      );
    }
  }

  Future<String?> verifyPhoneNumber(String phoneNumber) async {

    final result = await AsyncValue.guard(() async =>
        await ref.read(authRepositoryProvider).verifyPhoneNumber(phoneNumber));
    if(!result.hasError){
      return result.value;
    }
    return null;
  }

  Future<bool> changePhoneNumber(String token, String phoneNumber) async {

    final result = await AsyncValue.guard(() async =>
        await ref.read(authRepositoryProvider).changePhoneNumber(token, phoneNumber));
    if (!result.hasError) {
      state = AsyncData(state.value!.copyWith(phoneNumber: phoneNumber));
      OrbSnackBar.show(
        message: '전화번호가 변경되었어요.',
        type: OrbSnackBarType.info,
      );
    }
    return result.value ?? false;
  }

  @override
  FutureOr<User> build() async {
    // TODO: implement build
    await getUser();
    return state.value!;
  }
}
