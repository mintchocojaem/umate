import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';

final busProvider =
    AsyncNotifierProvider<BusNotifier, BusInfo?>(() => BusNotifier());

class BusNotifier extends AsyncNotifier<BusInfo?> {

  Future<void> getBusInfo() async {
    state = await AsyncValue.guard(
      () async {
        final jungmoonInfo = await ref.read(busRepositoryProvider).getBusList("단국대정문");
        final gomsangInfo = await ref.read(busRepositoryProvider).getBusList("곰상");
        return BusInfo(
          junmoonBus: jungmoonInfo,
          gomsangBus: gomsangInfo,
        );
      });
  }

  @override
  FutureOr<BusInfo?> build() async{
    // TODO: implement build
    await getBusInfo();
    return state.value;
  }
}
