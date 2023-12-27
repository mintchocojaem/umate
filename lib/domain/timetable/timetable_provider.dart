import 'dart:async';

import 'package:danvery/screens/main/timetable/widgets/schedule_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';

final timetableSearchTextProvider =
    StateProvider.autoDispose<String>((ref) => "");

final timetableSearchProvider =
    FutureProvider.autoDispose<List<LectureInfo>?>((ref) async {
  final String searchText = ref.watch(timetableSearchTextProvider);
  return searchText.isEmpty
      ? null
      : await ref.watch(timetableRepositoryProvider).getLectureInfo(searchText);
});

final timetableProvider = AsyncNotifierProvider<TimetableNotifier, Timetable>(
    () => TimetableNotifier());

class TimetableNotifier extends AsyncNotifier<Timetable> {

  Future<bool> editTimetableLectures(List<Lecture> lectures) async {
    final id = state.value!.id;
    return await ref
        .read(timetableRepositoryProvider)
        .editTimetableLectures(id: id, lectures: lectures)
        .then((value) {
      if (value) {
        state = AsyncValue.data(state.value!.copyWith(lectures: lectures));
      }
      return value;
    });
  }

  Future<void> addLecture(Lecture lecture) async {
    if (_checkTimeAvailable(lecture) && _checkSameTimeSchedule(null, lecture)) {
      final List<Lecture> lectures= List.from(state.value!.lectures!)..add(lecture);
      await editTimetableLectures(lectures);
    }
  }

  Future<void> setLecture(Lecture oldLecture, Lecture newLecture) async {
    if (_checkTimeAvailable(newLecture) &&
        _checkSameTimeSchedule(oldLecture, newLecture)) {
      final List<Lecture> lectures = state.value!.lectures!.map((lecture) {
        if (lecture == oldLecture) {
          return newLecture;
        }
        return lecture;
      }).toList();
      await editTimetableLectures(lectures);
    }
  }

  Future<void> deleteLecture(Lecture lecture) async {
    final List<Lecture> lectures = state.value!.lectures!
        .where((element) => element != lecture)
        .toList();
    await editTimetableLectures(lectures);
  }

  bool _checkTimeAvailable(Lecture newLecture) {
    for (LectureTime i in newLecture.times) {
      final ScheduleTimeFormat newStartTime = ScheduleTimeFormat(
        hour: int.parse(i.start.split(":")[0]),
        minute: int.parse(i.start.split(":")[1]),
      );
      final ScheduleTimeFormat newEndTime = ScheduleTimeFormat(
        hour: int.parse(i.end.split(":")[0]),
        minute: int.parse(i.end.split(":")[1]),
      );
      if (newStartTime.isAfter(newEndTime)) {
        return false;
      } else if (newStartTime.isAtSameMomentAs(newEndTime)) {
        return false;
      } else if (newEndTime
          .subtract(const ScheduleTimeFormat(hour: 0, minute: 30))
          .isBefore(newStartTime)) {
        return false;
      }
    }
    return true;
  }

  bool _checkSameTimeSchedule(Lecture? oldLecture, Lecture newLecture) {
    final List<Lecture> lectures = List.from(state.value!.lectures!);
    final List<LectureTime> lectureTimesInSameTime = [];
    lectures.remove(oldLecture);
    for (LectureTime i in newLecture.times) {
      for (Lecture j in lectures) {
        for (LectureTime k in j.times) {
          if (i.week == k.week) {
            final ScheduleTimeFormat newStartTime = ScheduleTimeFormat(
              hour: int.parse(i.start.split(":")[0]),
              minute: int.parse(i.start.split(":")[1]),
            );
            final ScheduleTimeFormat newEndTime = ScheduleTimeFormat(
              hour: int.parse(i.end.split(":")[0]),
              minute: int.parse(i.end.split(":")[1]),
            );
            final ScheduleTimeFormat existStartTime = ScheduleTimeFormat(
              hour: int.parse(k.start.split(":")[0]),
              minute: int.parse(k.start.split(":")[1]),
            );
            final ScheduleTimeFormat existEndTime = ScheduleTimeFormat(
              hour: int.parse(k.end.split(":")[0]),
              minute: int.parse(k.end.split(":")[1]),
            );

            if (newStartTime.isBefore(existStartTime) &&
                newEndTime.isAfter(existStartTime)) {
              lectureTimesInSameTime.add(k);
            } else if (newStartTime.isAfter(existStartTime) &&
                newStartTime.isBefore(existEndTime)) {
              lectureTimesInSameTime.add(k);
            } else if (newStartTime.isAtSameMomentAs(existStartTime) ||
                newEndTime.isAtSameMomentAs(existEndTime)) {
              lectureTimesInSameTime.add(k);
            }
          }
        }
      }
    }
    if (lectureTimesInSameTime.isEmpty) {
      return true;
    }
    return false;
  }

  Future<int> getTimetableInfo() async {
    return await ref
        .read(timetableRepositoryProvider)
        .getTimetableInfo()
        .then((value) async {
      final timetables = value;
      if (timetables.isEmpty) {
        return await ref
            .read(timetableRepositoryProvider)
            .addTimetable(name: "시간표");
      }
      return timetables.first.id;
    });
  }

  Future<void> getTimetable() async {
    final id = await getTimetableInfo();

    state = await AsyncValue.guard(() async {
      return await ref.read(timetableRepositoryProvider).getTimetable(id);
    });

    if (!state.hasError) {}
  }

  @override
  FutureOr<Timetable> build() async {
    // TODO: implement build
    await getTimetable();
    return state.value!;
  }
}
