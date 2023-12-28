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

  final int tableStartHour = 9;
  final int tableEndHour = 24;

  final List<String> weekDays = const [
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
    final timetable = ref.watch(timetableProvider);

    return OrbScaffold(
      orbAppBar: OrbAppBar(
        title: timetable.when(
            data: (value) => value.name,
            error: (error, trace) => "",
            loading: () => ""),
        trailing: Row(
          children: [
            IconButton(
              onPressed: () {
                ScheduleModal(
                  timetableStartHour: tableStartHour,
                  timetableEndHour: tableEndHour,
                  weekOfDay: WeekDays.values[DateTime.now().weekday - 1],
                  lectureStartTime: ScheduleTimeFormat(
                    hour: tableStartHour,
                    minute: 0,
                  ),
                  onAdded: (lecture) async {
                    return await ref
                        .read(timetableProvider.notifier)
                        .addLecture(lecture);
                  },
                  onSearch: () async {
                    final LectureInfo? lectureInfo =
                        await ref.read(routerProvider).push(
                              RouteInfo.timetableSearch.fullPath,
                            );
                    return lectureInfo;
                  },
                ).show(context);
              },
              icon: const Icon(Icons.add_rounded),
            ),
            IconButton(
              onPressed: () {
                OrbModalBottomSheet(
                  height: MediaQuery.of(context).size.height * 0.4,
                  showTopDragHolder: false,
                  titleText: "시간표 설정",
                  child: Column(
                    children: [
                      OrbListCardTile(
                        titleText: "시간표 이름 변경",
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          if (!ref.read(timetableProvider).hasValue) return;
                          final TextEditingController textEditingController =
                              TextEditingController();
                          textEditingController.text =
                              ref.read(timetableProvider).value!.name;
                          OrbDialog(
                            title: '시간표 이름 변경',
                            content: OrbTextFormField(
                              controller: textEditingController,
                              textInputAction: TextInputAction.done,
                              hintText: ref.read(timetableProvider).value?.name,
                            ),
                            rightButtonText: "변경",
                            leftButtonText: "취소",
                            onRightButtonPressed: () async {
                              await ref
                                  .read(timetableProvider.notifier)
                                  .changeTimetableName(
                                      textEditingController.text).whenComplete(
                                      () => Navigator.pop(context));
                            },
                            onLeftButtonPressed: () async {
                            },
                          ).show(context);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      OrbListCardTile(
                        titleText: "시간표 초기화",
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          if (!ref.read(timetableProvider).hasValue) return;
                          OrbDialog(
                            title: '시간표 초기화',
                            content: const Text(
                              '정말로 시간표를 초기화 할까요?\n(시간표 초기화시 모든 일정이 삭제되어요)',
                            ),
                            rightButtonText: "초기화",
                            leftButtonText: "취소",
                            onRightButtonPressed: () async {
                              await ref
                                  .read(timetableProvider.notifier)
                                  .initTimetable()
                                  .whenComplete(() => Navigator.pop(context));
                            },
                            onLeftButtonPressed: () async {
                            },
                          ).show(context);
                        },
                      ),
                    ],
                  ),
                ).show(context);
              },
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
                  onAdded: (lecture) async {
                    return await ref
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
                    return await ref
                        .read(timetableProvider.notifier)
                        .setLecture(oldLecture, newLecture);
                  },
                  onDeleted: () async {
                    return await ref
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
