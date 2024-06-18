import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../domain/models/timetable.dart';
import '../../domain/use_caces/get_first_timetable.dart';

final timetableProvider =
    AsyncNotifierProvider.autoDispose<TimetableNotifier, Timetable>(
  () => TimetableNotifier(),
);

class TimetableNotifier extends AutoDisposeAsyncNotifier<Timetable> {
  @override
  FutureOr<Timetable> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<Timetable> _fetch() async {
    final result = await ref.read(
      getFirstTimetableProvider(
        const NoParams(),
      ),
    );
    return result;
  }
}
