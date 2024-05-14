import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/models/schedule_type.dart';
import '../../domain/models/week_days.dart';
import '../../timetable_dependency_injections.dart';
import '../providers/states/schedule_state.dart';
import '../widgets/schedule_color_picker.dart';
import '../widgets/schedule_time_picker.dart';
import '../widgets/schedule_time_sheet.dart';

class ScheduleInfoScreen extends ConsumerStatefulWidget {
  final int startHour;
  final int endHour;
  final int weekdays;
  final int id;

  const ScheduleInfoScreen({
    super.key,
    required this.startHour,
    required this.endHour,
    required this.weekdays,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _ScheduleInfoScreenState();
  }
}

class _ScheduleInfoScreenState extends ConsumerState<ScheduleInfoScreen> {
  final titleController = TextEditingController();
  final professorController = TextEditingController();
  final placeController = TextEditingController();
  final memoController = TextEditingController();

  final lectureTimes = <ScheduleTime>[];

  late Color selectedColor;

  late final Schedule schedule;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schedule = ref.read(scheduleProvider.notifier).getScheduleById(widget.id)!;
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

    ref.listen(
      scheduleProvider,
      (prev, next) async {
        if (next is ScheduleFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        } else if (next is ScheduleSuccessState) {
          ref.read(routerServiceProvider).pop();
        }
      },
    );

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return OrbScaffold(
      appBar: OrbAppBar(
        title: '일정 정보',
        centerTitle: true,
        trailing: IconButton(
          icon: OrbIcon(
            Icons.done_rounded,
            color: currentPalette.surfaceDim,
          ),
          onPressed: () {
            ref.read(scheduleProvider.notifier).updateSchedule(
                  schedule: Schedule(
                    id: schedule.id,
                    name: titleController.text,
                    professor: professorController.text,
                    type: schedule.type,
                    memo: memoController.text,
                    color: selectedColor,
                    times: lectureTimes,
                  ),
                );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                                startHour: widget.startHour,
                                endHour: widget.endHour,
                                scheduleTime: lectureTimes[index],
                                isFirst: index == 0,
                                onTapAction: (scheduleTimeInfo) {
                                  setState(() {
                                    if (lectureTimes
                                        .contains(scheduleTimeInfo)) {
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
                                        widget.weekdays,
                                        (index) => WeekDays.values[index],
                                      ),
                                      onCanceled: () {
                                        ref.read(routerServiceProvider).pop();
                                      },
                                      startHour: widget.startHour,
                                      endHour: widget.endHour,
                                      scheduleTime: lectureTimes[index],
                                      onSaved: (scheduleTimeInfo) {
                                        setState(
                                          () {
                                            lectureTimes[index] =
                                                scheduleTimeInfo;
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
                          padding: const EdgeInsets.only(bottom: 8),
                          child: OrbTextField(
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
                ],
              ),
            ),
          ),
          OrbFilledButton(
            text: '삭제',
            backgroundColor: currentPalette.error,
            onPressed: () {
              OrbDialog(
                title: '일정 삭제',
                content: const OrbText(
                  '일정을 삭제하시겠습니까?',
                ),
                leftButtonText: '취소',
                rightButtonText: '일정 삭제',
                rightButtonColor: currentPalette.error,
                onLeftButtonPressed: () async {
                  return true;
                },
                onRightButtonPressed: () async {
                  ref
                      .read(scheduleProvider.notifier)
                      .removeSchedule(id: schedule.id);
                  return true;
                },
              ).show(context);
            },
          ),
        ],
      ),
    );
  }
}
