import 'package:flutter/foundation.dart';

import '../../../domain/models/timetable.dart';

@immutable
sealed class TimetableState {
  const TimetableState();
}

class TimetableInitialState extends TimetableState {
  const TimetableInitialState();
}

class TimetableLoadingState extends TimetableState {
  const TimetableLoadingState();
}

class TimetableSuccessState extends TimetableState {
  final Timetable timetable;

  const TimetableSuccessState({
    required this.timetable,
  });
}

class TimetableFailureState extends TimetableState {
  final String message;

  const TimetableFailureState({
    required this.message,
  });
}
