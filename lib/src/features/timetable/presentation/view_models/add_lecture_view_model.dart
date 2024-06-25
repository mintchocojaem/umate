import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/timetable/domain/use_caces/get_all_lecture_info.dart';

import '../../domain/models/lecture_info.dart';
import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/models/schedule_type.dart';
import '../../domain/use_caces/check_schedule_available.dart';
import '../../domain/use_caces/edit_timetable.dart';
import 'timetable_view_model.dart';

final addLectureViewModelProvider =
    AsyncNotifierProvider.autoDispose<AddLectureViewModel, List<LectureInfo>?>(
  () => AddLectureViewModel(),
);

class AddLectureViewModel extends AutoDisposeAsyncNotifier<List<LectureInfo>?> {
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
      () => ref.read(
        getAllLectureInfoProvider(
          GetAllLectureInfoParams(
            cancelToken: _cancelToken,
            keyword: keyword,
          ),
        ),
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
    final newLecture = Schedule(
      name: name,
      type: ScheduleType.lecture,
      professor: professor ?? '',
      times: times,
      memo: memo ?? '',
      color: color,
    );

    final timetable = ref.read(timetableViewModelProvider).requireValue;
    final result = await AsyncValue.guard(() {
      ref.read(
        checkScheduleAvailableProvider(
          CheckScheduleAvailableParams(
            timetable: timetable,
            newSchedule: newLecture,
          ),
        ),
      );

      return ref.read(
        editTimetableProvider(
          EditTimetableParams(
            id: timetable.id,
            schedules: timetable.schedules..add(newLecture),
          ),
        ),
      );
    });

    result.whenOrNull(
      data: (data) {
        ref.invalidate(timetableViewModelProvider);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );

    return result.hasValue;
  }
}
