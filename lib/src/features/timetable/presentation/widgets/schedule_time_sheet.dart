import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/models/week_days.dart';
import 'schedule_day_picker.dart';
import 'time_picker.dart';

class ScheduleTimeSheet extends OrbModalBottomSheet {
  final int startHour;
  final int endHour;
  final List<WeekDays> days;
  final ScheduleTime scheduleTime;

  final void Function(ScheduleTime time)? onSaved;
  final void Function()? onCanceled;

  const ScheduleTimeSheet({
    super.key,
    required this.startHour,
    required this.endHour,
    required this.days,
    required this.scheduleTime,
    this.onSaved,
    this.onCanceled,
  });

  @override
  // TODO: implement titleText
  String? get titleText => '시간 변경';

  @override
  // TODO: implement trailing
  Widget? get trailing => IconButton(
    icon: const Icon(Icons.close),
    onPressed: onCanceled,
  );

  @override
  // TODO: implement child
  Widget? get child {
    ScheduleTime currentScheduleTime = scheduleTime;
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Center(
                child: OrbText(
                  '요일',
                  type: OrbTextType.bodyLarge,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: OrbText(
                  '시작 시각',
                  type: OrbTextType.bodyLarge,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: OrbText(
                  '종료 시각',
                  type: OrbTextType.bodyLarge,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 180,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: ScheduleDayPicker(
                  days: days,
                  selectedDay: scheduleTime.day,
                  onDayChanged: (day) {
                    currentScheduleTime = ScheduleTime(
                      day: day,
                      start: currentScheduleTime.start,
                      end: currentScheduleTime.end,
                      place: currentScheduleTime.place,
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: TimePicker(
                  timetableStartHour: startHour,
                  timetableEndHour: endHour -1,
                  currentTime: scheduleTime.start,
                  onTimeChanged: (time) {
                    currentScheduleTime = ScheduleTime(
                      day: currentScheduleTime.day,
                      start: time,
                      end: currentScheduleTime.end,
                      place: currentScheduleTime.place,
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: TimePicker(
                  timetableStartHour: startHour,
                  timetableEndHour: endHour -1,
                  currentTime: scheduleTime.end,
                  onTimeChanged: (time) {
                    currentScheduleTime = ScheduleTime(
                      day: currentScheduleTime.day,
                      start: currentScheduleTime.start,
                      end: time,
                      place: currentScheduleTime.place,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        OrbFilledButton(
          text: '변경',
          onPressed: () async {
            onSaved?.call(currentScheduleTime);
          },
        ),
      ],
    );
  }
}