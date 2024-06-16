import 'package:flutter/material.dart';

import '../../../../core/utils/time_format.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_time.dart';
import '../../domain/models/week_days.dart';

typedef OnTapSchedule = void Function(Schedule schedule);
typedef OnLongPressTable = void Function(WeekDays day, int hour);

class ScheduleTable extends StatelessWidget {
  final int tableStartHour;
  final int tableEndHour;
  final int weekdays;
  final List<Schedule> schedules;
  final Color? unSelectedDayTextColor;
  final Color? selectedDayTextColor;
  final Color? selectedDayBackgroundColor;
  final Color? scheduleTextColor;
  final Color? tableTimeDividerColor;
  final Color? tableTimeTextColor;
  final OnTapSchedule? onTapSchedule;
  final OnLongPressTable? onLongPressTable;
  final ScrollPhysics? physics;

  const ScheduleTable({
    super.key,
    this.tableStartHour = 8,
    this.tableEndHour = 24,
    this.weekdays = 7,
    required this.schedules,
    this.unSelectedDayTextColor,
    this.selectedDayTextColor,
    this.selectedDayBackgroundColor,
    this.scheduleTextColor,
    this.tableTimeDividerColor,
    this.tableTimeTextColor,
    this.onTapSchedule,
    this.onLongPressTable,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().weekday - 1;

    final days = List.generate(weekdays, (index) => WeekDays.values[index]);

    Widget dayBar(double scheduleWidgetWidth) => Row(
          children: [
            const Expanded(child: SizedBox()),
            for (int i = 0; i < days.length; i++)
              SizedBox(
                width: scheduleWidgetWidth,
                child: Center(
                  child: today == i
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedDayBackgroundColor ?? Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: OrbText(
                            days[i].korean,
                            type: OrbTextType.bodyMedium,
                            color: selectedDayTextColor ?? Colors.white,
                          ),
                        )
                      : OrbText(
                          days[i].korean,
                          type: OrbTextType.bodyMedium,
                          color: unSelectedDayTextColor ?? Colors.black,
                        ),
                ),
              ),
          ],
        );

    List<Widget> addAllScheduleInfo(
        double scheduleWidgetWidth, double scheduleWidgetHeight) {
      final List<Widget> scheduleWidgets = [];
      final tableStartDuration = TimeFormat(
        hour: tableStartHour,
        minute: 0,
      );

      for (Schedule i in schedules) {
        for (ScheduleTime j in i.times) {
          final scheduleHeight =
              (j.end.subtract(j.start).hour * scheduleWidgetHeight) +
                  (j.end.subtract(j.start).minute * scheduleWidgetHeight / 60);

          final scheduleTextMaxLine = (((j.end.subtract(j.start).hour * 60) +
                  j.end.subtract(j.start).minute) ~/
              30);

          scheduleWidgets.add(
            Positioned(
              top: (j.start.subtract(tableStartDuration).hour *
                      scheduleWidgetHeight) +
                  (j.start.subtract(tableStartDuration).minute *
                      scheduleWidgetHeight /
                      60),
              left: (scheduleWidgetWidth * days.indexOf(j.day)) + 1,
              child: InkWell(
                onTap: () {
                  onTapSchedule?.call(i);
                },
                child: Container(
                  width: scheduleWidgetWidth - 2,
                  height: scheduleHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: i.color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              scheduleHeight >= 24
                                  ? OrbText(
                                      i.name,
                                      type: OrbTextType.bodySmall,
                                      maxLines: scheduleTextMaxLine > 3
                                          ? 3
                                          : scheduleTextMaxLine,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: OrbFontWeight.medium,
                                      color: Colors.white,
                                      height: 1.0,
                                    )
                                  : const OrbText(
                                      '...',
                                      type: OrbTextType.bodySmall,
                                      color: Colors.white,
                                      fontWeight: OrbFontWeight.medium,
                                      height: 0.1,
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
      return scheduleWidgets;
    }

    Widget scheduleTable(double tableTimeBarWidth, double scheduleWidgetWidth,
            double scheduleWidgetHeight) =>
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                for (int i = tableStartHour; i <= tableEndHour; i++)
                  SizedBox(
                    width: tableTimeBarWidth,
                    height: scheduleWidgetHeight,
                    child: Center(
                      child: OrbText(
                        i.toString(),
                        type: OrbTextType.bodySmall,
                        color: tableTimeTextColor ?? Colors.black,
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
                                child: GestureDetector(
                                  onLongPress: () {
                                    onLongPressTable?.call(
                                      days[i],
                                      j >= 24 ? 23 : j,
                                    );
                                  },
                                  child: Container(
                                    width: scheduleWidgetWidth,
                                    height: scheduleWidgetHeight,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: tableTimeDividerColor ??
                                              Colors.black,
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
                  ...addAllScheduleInfo(
                      scheduleWidgetWidth, scheduleWidgetHeight),
                ],
              ),
            ),
          ],
        );

    return LayoutBuilder(
      builder: (context, constraints) {
        final cellWidth = (constraints.maxWidth / days.length);
        final availableWidth = cellWidth - (cellWidth / 2 / days.length);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dayBar(availableWidth),
            Expanded(
              child: SingleChildScrollView(
                physics: physics,
                child: scheduleTable(
                  (cellWidth / 2),
                  availableWidth - 1,
                  constraints.maxHeight / (tableEndHour - tableStartHour + 1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
