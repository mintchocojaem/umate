import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/timetable/widgets/schedule_modal.dart';
import 'package:danvery/screens/main/timetable/widgets/schedule_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  final List<String> weekDays = const [
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
    "SATURDAY"
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
    final timetable = ref.watch(timetableProvider);
    return OrbScaffold(
      orbAppBar: OrbAppBar(
        trailing: const Icon(Icons.settings),
        showLoadingIndicator: timetable.isLoading,
      ),
      scrollBody: false,
      body: ScheduleTable(
        tableLineColor: themeData.colorScheme.onSurface,
        scheduleTextColor: const Color(0xFFffffff),
        barTextColor: themeData.colorScheme.onSurface,
        onTapSchedule: (Schedule schedule) {
          print(schedule);
          ScheduleModal().show(context);
        },
        schedules: timetable.when(
              data: (value) => [
                for (final Lecture lecture in value.lectures ?? [])
                  Schedule(
                    title: lecture.name,
                    times: [
                      for (final LectureTime time in lecture.times)
                        ScheduleTime(
                          startTime: time.start,
                          endTime: time.end,
                          day: weekDays.indexOf(time.week),
                          place: time.place,
                        ),
                    ],
                    color: Color(
                      int.parse(lecture.color),
                    ),
                  ),
              ],
              loading: () => [],
              error: (error, stackTrace) => [],
            ),
      ),
    );
  }
}
