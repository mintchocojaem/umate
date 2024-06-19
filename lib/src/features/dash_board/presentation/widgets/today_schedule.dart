import 'package:flutter/material.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/utils/time_format.dart';
import '../../../../design_system/orb/orb.dart';
import '../../../timetable/domain/models/week_days.dart';

class TodayScheduleItem {
  final String title;
  final TimeFormat startTime;
  final TimeFormat endTime;
  final String? place;
  final String? professor;
  final Color color;

  TodayScheduleItem({
    required this.title,
    required this.startTime,
    required this.endTime,
    this.place,
    this.professor,
    required this.color,
  });
}

class TodaySchedule extends StatelessWidget {
  final List<TodayScheduleItem> schedules;

  const TodaySchedule({
    super.key,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final DateTime now = DateTime.now();
    final today = now.weekday;

    //sort schedules by start time and end time
    schedules.sort((a, b) =>
        a.startTime.isBefore(b.startTime) || a.endTime.isBefore(b.endTime)
            ? -1
            : 1);

    //remove schedule that already passed
    schedules.removeWhere((element) {
      final currentTime = TimeFormat(
        hour: now.hour,
        minute: now.minute,
      );
      return element.endTime.isBefore(currentTime);
    });

    List<TodayScheduleItem> todaySchedules = [];

    if (schedules.length > 3) {
      for (int i = 0; i < 3; i++) {
        todaySchedules.add(schedules[i]);
      }
    } else {
      todaySchedules = schedules;
    }

    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: context.palette.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: todaySchedules.isNotEmpty
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              OrbText(
                WeekDays.values[today - 1].korean,
                type: OrbTextType.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              OrbText(
                "${now.month}월 ${now.day}일",
                type: OrbTextType.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          todaySchedules.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final schedule in todaySchedules)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 4,
                                decoration: BoxDecoration(
                                  color: schedule.color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                    ),
                                    child: OrbText(
                                      schedule.title,
                                      type: OrbTextType.bodyMedium,
                                      fontWeight: OrbFontWeight.medium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  OrbText(
                                    "${schedule.startTime.toString()} ~ ${schedule.endTime.toString()}",
                                    type: OrbTextType.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              : const Expanded(
                  child: Center(
                    child: OrbText(
                      "현재 일정이 존재하지 않아요.\n(일정은 시간표에서 추가할 수 있어요)",
                      type: OrbTextType.bodyMedium,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
