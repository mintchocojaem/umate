import 'package:danvery/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnTapLecture = void Function(Lecture lecture);
typedef OnLongPressTable = void Function(int day, int hour);

enum ScheduleType{
  lecture("LECTURE"),
  schedule("SCHEDULE");

  final String value;
  const ScheduleType(this.value);
}

class ScheduleTimeFormat {
  final int hour;
  final int minute;

  const ScheduleTimeFormat({required this.hour, required this.minute});

  ScheduleTimeFormat add(ScheduleTimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime = DateTime(now.year, now.month, now.day, hour, minute).add(
      Duration(
        hours: scheduleTimeFormat.hour,
        minutes: scheduleTimeFormat.minute,
      ),
    );
    return ScheduleTimeFormat(
      hour: newTime.hour,
      minute: newTime.minute,
    );
  }

  ScheduleTimeFormat subtract(ScheduleTimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime =
    DateTime(now.year, now.month, now.day, hour, minute).subtract(
      Duration(
        hours: scheduleTimeFormat.hour,
        minutes: scheduleTimeFormat.minute,
      ),
    );
    return ScheduleTimeFormat(
      hour: newTime.hour,
      minute: newTime.minute,
    );
  }

  bool isAfter(ScheduleTimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime = DateTime(now.year, now.month, now.day, hour, minute);
    final compareTime = DateTime(now.year, now.month, now.day, scheduleTimeFormat.hour, scheduleTimeFormat.minute);
    return newTime.isAfter(compareTime);
  }

  bool isAtSameMomentAs(ScheduleTimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime = DateTime(now.year, now.month, now.day, hour, minute);
    final compareTime = DateTime(now.year, now.month, now.day, scheduleTimeFormat.hour, scheduleTimeFormat.minute);
    return newTime.isAtSameMomentAs(compareTime);
  }

  bool isBefore(ScheduleTimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime = DateTime(now.year, now.month, now.day, hour, minute);
    final compareTime = DateTime(now.year, now.month, now.day, scheduleTimeFormat.hour, scheduleTimeFormat.minute);
    return newTime.isBefore(compareTime);
  }

  @override
  String toString() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}

enum WeekDays {
  monday("MONDAY", "월"),
  tuesday("TUESDAY", "화"),
  wednesday("WEDNESDAY", "수"),
  thursday("THURSDAY", "목"),
  friday("FRIDAY", "금"),
  sat("SATURDAY", "토"),
  sun("SUNDAY", "일");

  final String english;
  final String korean;

  const WeekDays(this.english, this.korean);
}

class ScheduleTable extends StatelessWidget {
  final int tableStartHour;
  final int tableEndHour;
  final List<String> days;
  final List<Lecture> lectures;
  final Color? barTextColor;
  final Color? scheduleTextColor;
  final Color? tableLineColor;
  final OnTapLecture? onTapSchedule;
  final OnLongPressTable? onLongPressTable;

  const ScheduleTable({
    super.key,
    this.tableStartHour = 8,
    this.tableEndHour = 24,
    this.days = const ['월', '화', '수', '목', '금'],
    required this.lectures,
    this.barTextColor,
    this.scheduleTextColor,
    this.tableLineColor,
    this.onTapSchedule,
    this.onLongPressTable,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final today = DateTime.now().weekday - 1;

    final scheduleWidgetWidth = (MediaQuery.of(context).size.width / 6);
    final scheduleWidgetHeight = (MediaQuery.of(context).size.height / 16);

    Widget dayBar() {
      return Container(
        color: themeData.colorScheme.background,
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            for (int i = 0; i < days.length; i++)
              Container(
                constraints: BoxConstraints(
                  minHeight: scheduleWidgetHeight / 2,
                  minWidth: scheduleWidgetWidth,
                ),
                child: Center(
                  child: today == i
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.primary,
                              shape: BoxShape.circle),
                          child: Text(
                            days[i],
                            style: themeData.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          days[i],
                          style: themeData.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: barTextColor,
                          ),
                        ),
                ),
              ),
          ],
        ),
      );
    }

    List<Widget> scheduleWidget() {
      List<String> weekDays = [
        WeekDays.monday.english,
        WeekDays.tuesday.english,
        WeekDays.wednesday.english,
        WeekDays.thursday.english,
        WeekDays.friday.english,
      ];

      final tableStartTime = DateFormat.H().parse(tableStartHour.toString());
      final tableStartDuration = Duration(hours: tableStartTime.hour);

      List<Widget> result = [];
      for (Lecture i in lectures) {
        for (LectureTime j in i.times) {
          final DateTime startTime = DateFormat.Hm().parse(j.start);
          final Duration startDuration =
              Duration(hours: startTime.hour, minutes: startTime.minute);
          final DateTime endTime = DateFormat.Hm().parse(j.end);
          final scheduleHeight =
              (endTime.subtract(startDuration).hour * scheduleWidgetHeight) +
                  (endTime.subtract(startDuration).minute *
                      scheduleWidgetHeight /
                      60);
          final scheduleTopMargin =
              (startTime.subtract(tableStartDuration).hour *
                      scheduleWidgetHeight) +
                  (startTime.subtract(tableStartDuration).minute *
                      scheduleWidgetHeight /
                      60);
          final scheduleLeftMargin =
              scheduleWidgetWidth * (weekDays.indexOf(j.week));
          final scheduleTextMaxLine =
              (((endTime.subtract(startDuration).hour * 60) +
                      endTime.subtract(startDuration).minute) ~/
                  30);
          result.add(
            Positioned(
              top: scheduleTopMargin,
              left: scheduleLeftMargin + 1,
              child: GestureDetector(
                onTap: () {
                  onTapSchedule?.call(i);
                },
                child: Container(
                  width: scheduleWidgetWidth - 2,
                  height: scheduleHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(int.parse(i.color)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                i.name,
                                style: themeData.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  color: scheduleTextColor,
                                ),
                                maxLines: scheduleTextMaxLine,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (scheduleHeight >= scheduleWidgetHeight &&
                                  i.times.first.place != null &&
                                  scheduleTextMaxLine > 2)
                                Text(
                                  i.times.first.place!,
                                  style:
                                      themeData.textTheme.bodySmall?.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    color: scheduleTextColor,
                                  ),
                                  maxLines: scheduleTextMaxLine - 1,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
      return result;
    }

    Widget scheduleTable() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              for (int i = tableStartHour; i <= tableEndHour; i++)
                SizedBox(
                  width: scheduleWidgetWidth / 2,
                  height: scheduleWidgetHeight,
                  child: Center(
                    child: Text(
                      i.toString(),
                      style: themeData.textTheme.bodySmall?.copyWith(
                        color: barTextColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: scheduleWidgetHeight / 2),
            child: Stack(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < days.length; i++)
                      Column(
                        children: [
                          for (int j = tableStartHour; j <= tableEndHour; j++)
                            IntrinsicWidth(
                              child: InkWell(
                                onLongPress: () {
                                  onLongPressTable?.call(i, j >= 24 ? 23 : j);
                                },
                                child: Container(
                                  width: scheduleWidgetWidth,
                                  height: scheduleWidgetHeight,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: tableLineColor!,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
                ...scheduleWidget(),
              ],
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          dayBar(),
          scheduleTable(),
        ],
      ),
    );
  }
}
