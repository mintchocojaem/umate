import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/timetable.dart';
import '../../domain/use_caces/timetable_use_cases.dart';

final timetableControllerProvider =
    AsyncNotifierProvider.autoDispose<TimetableController, Timetable>(
  () => TimetableController(),
);

class TimetableController extends AutoDisposeAsyncNotifier<Timetable> {
  @override
  FutureOr<Timetable> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<Timetable> _fetch() async {
    final result =
        await ref.read(timetableUseCasesProvider).getFirstTimetable();
    return result;
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }
}
