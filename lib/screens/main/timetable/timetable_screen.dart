import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/timetable/widgets/timetable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrbScaffold(
      defaultAppBar: false,
      scrollBody: false,
      body: SafeArea(
        child: Timetable(
          schedules: [
            Schedule(title: "컴퓨터구조", times: [
              ScheduleTime(startTime: "10:00", endTime: "11:15", day: 1),
              ScheduleTime(startTime: "10:00", endTime: "11:15", day: 3),
            ], color: Colors.red),
          ],
        ),
      ),
    );
  }
}
