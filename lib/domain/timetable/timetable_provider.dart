import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';

final timetableProvider =
AsyncNotifierProvider<TimetableNotifier, Timetable>(() => TimetableNotifier());

class TimetableNotifier extends AsyncNotifier<Timetable> {

  Future<void> getTimetableInfo() async {
    state = await AsyncValue.guard(
            () async {
          return await ref.read(timetableRepositoryProvider).getTimetableInfo().then((value) => value.first);
        });
  }

  Future<void> getTimetable() async {

    await getTimetableInfo();
    
    state = await AsyncValue.guard(
            () async {
          return await ref.read(timetableRepositoryProvider).getTimetable(state.value!.id);
        });

    if(!state.hasError){

    }
  }

  @override
  FutureOr<Timetable> build() async{
    // TODO: implement build
    await getTimetable();
    return state.value!;
  }
}
