import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/timetable/widgets/timetable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      orbAppBar: const OrbAppBar(
        trailing: Icon(Icons.settings),
      ),
      scrollBody: false,
      body: Timetable(
        tableLineColor: themeData.colorScheme.onSurface,
        scheduleTextColor: const Color(0xFFf0f0f0),
        barTextColor: themeData.colorScheme.onSurface,
        schedules: [
          Schedule(
            title: "컴퓨터구조",
            times: [
              ScheduleTime(
                startTime: "08:30",
                endTime: "11:00",
                day: 1,
                place: "E3-1 101",
              ),

              ScheduleTime(
                startTime: "10:00",
                endTime: "11:00",
                day: 5,
                place: "E3-1 101",
              ),
            ],
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
