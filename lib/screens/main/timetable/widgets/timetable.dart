import 'package:flutter/material.dart';

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
  final String? description;

  Schedule({
    required this.title,
    required this.times,
    required this.color,
    this.description,
  });
}

class Timetable extends StatelessWidget {
  final int startHour;
  final int endHour;
  final List<String> days;
  final List<Schedule> schedules;

  const Timetable({
    Key? key,
    this.startHour = 8,
    this.endHour = 24,
    this.days = const ['월', '화', '수', '목', '금'],
    required this.schedules,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox()),
              for (int i = 0; i < days.length; i++)
                Expanded(
                  flex: 3,
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 24,
                    ),
                    child: Center(
                      child: Text(
                        days[i],
                        style: themeData.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    for (int i = startHour; i < endHour; i++)
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 48,
                        ),
                        child: Center(
                          child: Text(
                            i.toString(),
                            style: themeData.textTheme.bodySmall,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              for (int i = 0; i < days.length; i++)
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      for (int j = startHour; j < endHour; j++)
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 48,
                          ),
                          child: Divider(
                            color: themeData.colorScheme.onBackground,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
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
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
