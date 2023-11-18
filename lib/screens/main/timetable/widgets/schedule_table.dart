import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleTime {
  final String startTime;
  final String endTime;
  final int day;
  final String? place;

  ScheduleTime({
    required this.startTime,
    required this.endTime,
    required this.day,
    this.place,
  });
}

class Schedule {
  final String title;
  final List<ScheduleTime> times;
  final Color color;

  Schedule({
    required this.title,
    required this.times,
    required this.color,
  });
}

class TimetableHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  TimetableHeader({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return widget;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 40;

  @override
  // TODO: implement minExtent
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

typedef OnTapSchedule = void Function(Schedule schedule);

class ScheduleTable extends StatelessWidget {
  final int tableStartHour;
  final int tableEndHour;
  final List<String> days;
  final List<Schedule> schedules;
  final Color? barTextColor;
  final Color? scheduleTextColor;
  final Color? tableLineColor;
  final OnTapSchedule? onTapSchedule;

  const ScheduleTable({
    Key? key,
    this.tableStartHour = 8,
    this.tableEndHour = 24,
    this.days = const ['월', '화', '수', '목', '금'],
    required this.schedules,
    this.barTextColor,
    this.scheduleTextColor,
    this.tableLineColor,
    this.onTapSchedule,
  }) : super(key: key);

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
      final tableStartTime = DateFormat.H().parse(tableStartHour.toString());
      final tableStartDuration = Duration(hours: tableStartTime.hour);

      List<Widget> result = [];
      for (Schedule i in schedules) {
        for (ScheduleTime j in i.times) {
          final DateTime startTime = DateFormat.Hm().parse(j.startTime);
          final Duration startDuration =
              Duration(hours: startTime.hour, minutes: startTime.minute);
          final DateTime endTime = DateFormat.Hm().parse(j.endTime);
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
          final scheduleLeftMargin = scheduleWidgetWidth * (j.day - 1);
          final scheduleTextMaxLine =
              (((endTime.subtract(startDuration).hour * 60) +
                      endTime.subtract(startDuration).minute) ~/
                  30);

          result.add(
            Positioned(
              top: (scheduleWidgetHeight / 2) + scheduleTopMargin,
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
                              Text(
                                i.title,
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
        children: [
          Flexible(
            child: Column(
              children: [
                for (int i = tableStartHour; i <= tableEndHour; i++)
                  Container(
                    constraints: BoxConstraints(
                      minHeight: scheduleWidgetHeight,
                    ),
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
          ),
          Stack(
            children: [
              Row(
                children: [
                  for (int i = 0; i < days.length; i++)
                    Column(
                      children: [
                        for (int j = tableStartHour; j <= tableEndHour; j++)
                          IntrinsicWidth(
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: scheduleWidgetHeight,
                                minWidth: scheduleWidgetWidth,
                              ),
                              child: Divider(
                                color: tableLineColor,
                                thickness: 0.5,
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
        ],
      );
    }

    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: TimetableHeader(
            widget: dayBar(),
          ),
        ),
        SliverToBoxAdapter(
          child: scheduleTable(),
        ),
      ],
    );
  }
}
