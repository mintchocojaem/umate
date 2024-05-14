import 'package:flutter/material.dart';

@immutable
sealed class ScheduleState {
  const ScheduleState();
}

class ScheduleInitialState extends ScheduleState {
  const ScheduleInitialState();
}

class ScheduleSuccessState extends ScheduleState {
  const ScheduleSuccessState();
}

class ScheduleFailureState extends ScheduleState {
  final String message;

  const ScheduleFailureState({
    required this.message,
  });
}