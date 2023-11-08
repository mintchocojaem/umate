import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';

final busProvider =
    AsyncNotifierProvider<BusNotifier, BusInfo>(() => BusNotifier());

class BusNotifier extends AsyncNotifier<BusInfo> {

  Future<void> getBusInfo() async {
    state = await AsyncValue.guard(
      () async {
        final jungmoonInfo = ref.read(busRepositoryProvider).getBusList("단국대정문");
        final gomsangInfo = ref.read(busRepositoryProvider).getBusList("곰상");
        return BusInfo(
          jungmoonBus: await jungmoonInfo as BusList,
          gomsangBus: await gomsangInfo as BusList,
        );
      });
  }

  @override
  FutureOr<BusInfo> build() async{
    // TODO: implement build
    await getBusInfo();
    /*
    Timer.periodic(const Duration(seconds: 30), (timer) async{
      await getBusInfo();
    });
     */
    return state.value!;
  }
}
