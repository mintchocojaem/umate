import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/lecture_info.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/models/schedule_type.dart';
import '../../domain/use_caces/timetable_use_cases.dart';
import 'timetable_controller.dart';

final addLectureControllerProvider =
    AsyncNotifierProvider.autoDispose<AddLectureController, List<LectureInfo>?>(
  () => AddLectureController(),
);

class AddLectureController
    extends AutoDisposeAsyncNotifier<List<LectureInfo>?> {
  CancelToken? _cancelToken;

  @override
  FutureOr<List<LectureInfo>?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> search({
    required String keyword,
    bool isTyping = false,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    if (keyword.isEmpty) {
      state = const AsyncData(<LectureInfo>[]);
      return;
    }

    if (!isTyping) {
      state = const AsyncLoading();
    }

    final result = await AsyncValue.guard(
      () => ref.read(timetableUseCasesProvider).getAllLectureInfo(
            cancelToken: _cancelToken,
            keyword: keyword,
          ),
    );

    result.whenOrNull(
      data: (data) {
        state = AsyncData(data);
      },
      error: (error, stackTrace) {
        state = const AsyncData(<LectureInfo>[]);
      },
    );
  }

  Future<bool> addLecture({
    required String name,
    String? professor,
    required List<ScheduleTime> times,
    String? memo,
    required Color color,
  }) async {
    final timetable = ref.read(timetableControllerProvider).requireValue;
    final result = await AsyncValue.guard(
      () => ref.read(timetableUseCasesProvider).addSchedule(
            timetable: timetable,
            name: name,
            type: ScheduleType.lecture,
            times: times,
            memo: memo,
            color: color,
          ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidate(timetableControllerProvider);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );

    return result.hasValue;
  }
}
