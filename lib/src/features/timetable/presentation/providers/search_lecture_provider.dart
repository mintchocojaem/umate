import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/timetable/domain/use_caces/get_all_lecture_info.dart';

import '../../domain/models/lecture_info.dart';
import '../../domain/models/schedule.dart';
import '../../domain/use_caces/add_schedule.dart';
import 'timetable_provider.dart';

final searchLectureProvider = AsyncNotifierProvider.autoDispose<
    SearchLectureNotifier, List<LectureInfo>?>(
  () => SearchLectureNotifier(),
);

class SearchLectureNotifier
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
    required Schedule schedule,
  }) async {
    final timetable = ref.read(timetableProvider);
    final result = await AsyncValue.guard(
          () => ref.read(
        addScheduleProvider(
          AddScheduleParams(
            schedule: schedule,
            timetable: timetable.requireValue,
          ),
        ),
      ),
    );

    result.whenOrNull(
      data: (data) {
        ref.invalidate(timetableProvider);
      },
      error: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );

    return result.hasValue;
  }
}
