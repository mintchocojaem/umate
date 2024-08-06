import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/app_exception.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/models/schedule_type.dart';
import '../../domain/models/timetable.dart';
import '../../domain/models/week_days.dart';
import '../controllers/schedule_controller.dart';
import '../controllers/timetable_controller.dart';
import '../widgets/schedule_color_picker.dart';
import '../widgets/schedule_time_picker.dart';
import '../widgets/schedule_time_sheet.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  final int id;

  const ScheduleScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _ScheduleScreenState();
  }
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  final titleController = TextEditingController();
  final professorController = TextEditingController();
  final placeController = TextEditingController();
  final memoController = TextEditingController();

  final lectureTimes = <ScheduleTime>[];

  late Color selectedColor;

  late final Timetable timetable;
  late final Schedule schedule;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timetable = ref.read(timetableControllerProvider).requireValue;
    schedule =
        timetable.schedules.firstWhere((element) => element.id == widget.id);
    titleController.text = schedule.name;
    professorController.text = schedule.professor;
    placeController.text = schedule.times
        .map((e) => e.place)
        .where((element) => element.isNotEmpty)
        .join(',');
    memoController.text = schedule.memo;
    lectureTimes.addAll(schedule.times);
    selectedColor = schedule.color;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    professorController.dispose();
    placeController.dispose();
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    lectureTimes.sort((a, b) => a.start.isBefore(b.start) ? -1 : 1);
    lectureTimes.sort((a, b) => a.day.index.compareTo(b.day.index));

    ref.listen(
      scheduleControllerProvider(widget.id),
      (_, next) {
        if (!next.isLoading && next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showErrorSnackBar(
            error: error,
          );
        }
      },
    );

    return OrbScaffold(
      appBar: OrbAppBar(
        title: '일정 정보',
        centerTitle: true,
        trailing: IconButton(
          icon: OrbIcon(
            Icons.done_rounded,
            color: context.palette.surfaceDim,
          ),
          onPressed: () async {
            final result = await ref
                .read(scheduleControllerProvider(widget.id).notifier)
                .updateSchedule(
                  name: titleController.text,
                  professor: professorController.text,
                  memo: memoController.text,
                  color: selectedColor,
                  times: lectureTimes,
                );

            if (!context.mounted) return;

            if (result) {
              context.showSnackBar(
                message: '일정이 수정되었습니다.',
              );
              ref.read(routerServiceProvider).pop();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          OrbDialog(
            title: '일정 삭제',
            content: const OrbText(
              '일정을 삭제하시겠습니까?',
            ),
            leftButtonText: '취소',
            rightButtonText: '삭제',
            rightButtonColor: context.palette.error,
            onLeftButtonPressed: () async {
              return true;
            },
            onRightButtonPressed: () async {
              final result = await ref
                  .read(scheduleControllerProvider(widget.id).notifier)
                  .deleteSchedule();

              if (!context.mounted) return true;

              if (result) {
                context.showSnackBar(
                  message: '일정이 삭제되었습니다.',
                );
                ref.read(routerServiceProvider).pop();
              }
              return true;
            },
          ).show(context);
        },
        backgroundColor: context.palette.error,
        shape: const CircleBorder(),
        child: OrbIcon(
          Icons.delete_rounded,
          color: context.palette.errorContainer,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            OrbTextField(
              controller: titleController,
              hintText: '제목',
            ),
            schedule.type == ScheduleType.lecture
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                    ),
                    child: OrbTextField(
                      controller: professorController,
                      hintText: '교수명',
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 16),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              clipBehavior: Clip.none,
              child: Column(
                children: [
                  ...List.generate(
                    lectureTimes.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ScheduleTimePicker(
                          key: ValueKey(lectureTimes[index]),
                          startHour: timetable.startHour,
                          endHour: timetable.endHour,
                          scheduleTime: lectureTimes[index],
                          isFirst: index == 0,
                          onTapAction: (scheduleTimeInfo) {
                            setState(() {
                              if (lectureTimes.contains(scheduleTimeInfo)) {
                                lectureTimes.remove(scheduleTimeInfo);
                              } else {
                                //order by adding time
                                lectureTimes.add(scheduleTimeInfo);
                              }
                            });
                          },
                          onTap: () {
                            showOrbModalBottomSheet(
                              context,
                              ScheduleTimeSheet(
                                days: List.generate(
                                  timetable.weekdays,
                                  (index) => WeekDays.values[index],
                                ),
                                onCanceled: () {
                                  ref.read(routerServiceProvider).pop();
                                },
                                startHour: timetable.startHour,
                                endHour: timetable.endHour,
                                scheduleTime: lectureTimes[index],
                                onSaved: (scheduleTimeInfo) {
                                  setState(
                                    () {
                                      lectureTimes[index] = scheduleTimeInfo;
                                    },
                                  );
                                  ref.read(routerServiceProvider).pop();
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            placeController.text.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: OrbTextField(
                      readOnly: true,
                      controller: placeController,
                      hintText: '장소',
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 8),
            OrbTextField(
              controller: memoController,
              hintText: '메모',
              maxLines: 5,
              maxLength: 500,
            ),
            const SizedBox(height: 16),
            ScheduleColorPicker(
              selectByColor: selectedColor,
              onColorChanged: (color) {
                setState(
                  () {
                    selectedColor = color;
                  },
                );
              },
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
