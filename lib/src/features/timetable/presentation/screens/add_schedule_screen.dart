import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/models/schedule_time_format.dart';
import '../../domain/models/schedule_type.dart';
import '../../domain/models/week_days.dart';
import '../../timetable_dependency_injections.dart';
import '../providers/states/schedule_state.dart';
import '../widgets/schedule_color_picker.dart';
import '../widgets/schedule_time_picker.dart';
import '../widgets/schedule_time_sheet.dart';

class AddScheduleScreen extends ConsumerStatefulWidget {
  final int startHour;
  final int endHour;
  final int weekdays;

  const AddScheduleScreen({
    super.key,
    required this.startHour,
    required this.endHour,
    required this.weekdays,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _AddScheduleScreenState();
  }
}

class _AddScheduleScreenState extends ConsumerState<AddScheduleScreen> {
  final nameController = TextEditingController();
  final professorController = TextEditingController();
  final placeController = TextEditingController();
  final memoController = TextEditingController();

  final lectureTimes = <ScheduleTime>[];

  Color selectedColor = ScheduleColorPicker
      .colors[Random().nextInt(ScheduleColorPicker.colors.length)];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lectureTimes.add(
      ScheduleTime(
        day: WeekDays.monday,
        startTime: ScheduleTimeFormat(
          hour: widget.startHour,
          minute: 0,
        ),
        endTime: ScheduleTimeFormat(
          hour: widget.startHour + 1,
          minute: 0,
        ),
        place: '',
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    placeController.dispose();
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ref.listen(
      scheduleProvider,
      (prev, next) {
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

    return OrbScaffold(
      resizeToAvoidBottomInset: true,
      appBar: OrbAppBar(
        title: '일정 정보',
        centerTitle: true,
        trailing: IconButton(
          icon: const OrbIcon(
            Icons.check_rounded,
          ),
          onPressed: () {
            ref.read(scheduleProvider.notifier).addSchedule(
                  schedule: Schedule(
                    name: nameController.text,
                    professor: professorController.text,
                    type: ScheduleType.schedule,
                    memo: memoController.text,
                    color: selectedColor,
                    times: lectureTimes,
                  ),
                );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            OrbTextField(
              controller: nameController,
              hintText: '수업명',
            ),
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
                                startHour: widget.startHour,
                                endHour: widget.endHour,
                                onCanceled: () {
                                  ref
                                      .read(routerServiceProvider)
                                      .pop();
                                },
                                days: List.generate(
                                  widget.weekdays,
                                  (index) => WeekDays.values[index],
                                ),
                                scheduleTime: lectureTimes[index],
                                onSaved: (scheduleTimeInfo) {
                                  setState(() {
                                    lectureTimes[index] = scheduleTimeInfo;
                                  });
                                  ref
                                      .read(routerServiceProvider)
                                      .pop();
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
            ),
            const SizedBox(height: 16),
            ScheduleColorPicker(
              selectByColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
