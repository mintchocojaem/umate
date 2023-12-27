import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/routes/route_path.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:danvery/screens/main/timetable/widgets/schedule_modal.dart';
import 'package:danvery/screens/main/timetable/widgets/schedule_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/timetable/timetable.dart';
import '../../../domain/timetable/timetable_provider.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({super.key});

  final List<String> weekDays = const [
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
  ];
  final int tableStartHour = 9;
  final int tableEndHour = 24;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
    final timetable = ref.watch(timetableProvider);
    return OrbScaffold(
      orbAppBar: OrbAppBar(
        title: "시간표",
        trailing: Row(
          children: [
            IconButton(
              onPressed: () {
                ScheduleModal(
                  timetableStartHour: tableStartHour,
                  timetableEndHour: tableEndHour,
                  weekOfDay: WeekDays.values[DateTime.now().weekday - 1],
                  lectureStartTime: const ScheduleTimeFormat(
                    hour: tableStartHour,
                    minute: 0,
                  ),
                  onAdded: (lecture) async {
                    await ref
                        .read(timetableProvider.notifier)
                        .addLecture(lecture);
                  },
                  onSearch: () async {
                    final LectureInfo? lectureInfo = await ref.read(routerProvider).push(
                          RouteInfo.timetableSearch.fullPath,
                        );
                    return lectureInfo;
                  },
                ).show(context);
              },
              icon: const Icon(Icons.add_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ],
        ),
        showLoadingIndicator:
            !timetable.hasValue || timetable.value?.lectures == null,
      ),
      scrollBody: false,
      body: timetable.when(
          data: (value) {
            return ScheduleTable(
              tableStartHour: tableStartHour,
              tableEndHour: tableEndHour,
              tableLineColor: themeData.colorScheme.onSurface,
              scheduleTextColor: Colors.white,
              barTextColor: themeData.colorScheme.onSurface,
              onLongPressTable: (day, hour) {
                ScheduleModal(
                  timetableStartHour: tableStartHour,
                  timetableEndHour: tableEndHour,
                  lecture: null,
                  weekOfDay: WeekDays.values[day],
                  lectureStartTime: ScheduleTimeFormat(
                    hour: hour,
                    minute: 0,
                  ),
                  onEdited: (oldLecture, newLecture) async {
                    //add lecture
                  },
                  onAdded: (lecture) async {
                    await ref
                        .read(timetableProvider.notifier)
                        .addLecture(lecture);
                  },
                ).show(context);
              },
              onTapSchedule: (Lecture lecture) {
                ScheduleModal(
                  timetableStartHour: tableStartHour,
                  timetableEndHour: tableEndHour,
                  lecture: lecture,
                  onEdited: (oldLecture, newLecture) async {
                    await ref
                        .read(timetableProvider.notifier)
                        .setLecture(oldLecture, newLecture);
                  },
                  onDeleted: () async {
                    await ref
                        .read(timetableProvider.notifier)
                        .deleteLecture(lecture);
                  },
                ).show(context);
              },
              lectures: value.lectures!,
            );
          },
          error: (error, trace) => null,
          loading: () => null),
    );
  }
}
