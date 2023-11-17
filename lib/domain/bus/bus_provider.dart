import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';

final busProvider =
    AsyncNotifierProvider<BusNotifier, BusInfo?>(() => BusNotifier());

class BusNotifier extends AsyncNotifier<BusInfo?> {

  Future<void> getBusInfo() async {
    state = await AsyncValue.guard(
      () async {
        final jungmoonInfo = ref.read(busRepositoryProvider).getBusList("단국대정문");
        final gomsangInfo = ref.read(busRepositoryProvider).getBusList("곰상");
        final List<BusList?> busList = await Future.wait([jungmoonInfo, gomsangInfo]);
        if(busList.every((element) => element != null)) {
          return BusInfo(
              jungmoonBus: busList[0]!,
              gomsangBus: busList[1]!,
          );
        }
        return null;
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
