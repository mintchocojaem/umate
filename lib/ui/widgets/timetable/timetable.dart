import 'package:danvery/domain/timetable/model/lecture/schedule_model.dart';
import 'package:danvery/domain/timetable/model/lecture/schedule_time.dart';

import '/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/theme/app_text_theme.dart';

class Timetable extends StatelessWidget {
  final List<ScheduleModel>? schedules;

  final int tableStartTime;
  final int tableEndTime;
  final int today;
  final void Function(ScheduleModel subjectModel)? onSubjectTap;
  final bool isLoading;

  const Timetable({
    super.key,
    required this.schedules,
    required this.tableStartTime,
    required this.tableEndTime,
    this.today = 0,
    this.onSubjectTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double cellHeight = (width - (width / 8)) / 7;
    final double dayCellHeight = cellHeight / 2;

    int columnLength = tableEndTime - tableStartTime;

    List<String> week = ['월', '화', '수', '목', '금'];

    Widget buildTimeColumn(
        double dayCellHeight, double cellWidth, int columnLength) {
      return SizedBox(
        width: 35,
        child: Column(
          children: [
            const Divider(
              color: Colors.grey,
              height: 1,
            ),
            Column(
              children: [
                ...List.generate(
                  columnLength + 1,
                  (index) {
                    return SizedBox(
                      height: cellWidth + 1,
                      child: Center(
                          child: Text(
                        '${(index) + tableStartTime}',
                        style: tinyStyle.copyWith(color: Palette.grey),
                      )),
                    );
                  },
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 1,
            )
          ],
        ),
      );
    }

    List<Widget> buildColumnSubjects(int index, List<ScheduleModel>? subjects,
        double dayCellHeight, double cellWidth) {
      DateTime startTableTime =
          DateFormat('HH').parse(tableStartTime.toString());
      Duration startTableDuration = Duration(hours: startTableTime.hour);

      List<Widget> result = [];
      if (subjects != null) {
        for (ScheduleModel i in subjects) {
          for (ScheduleTime j in i.times) {
            if (j.week == week[index]) {
              final DateTime startTime = DateFormat('HH:mm').parse(j.start);
              final Duration startDuration =
                  Duration(hours: startTime.hour, minutes: startTime.minute);
              final DateTime endTime = DateFormat('HH:mm').parse(j.end);

              final double height =
                  (endTime.subtract(startDuration).hour * (cellWidth + 1)) +
                      (endTime.subtract(startDuration).minute *
                          (cellWidth + 1) /
                          60);
              final double width = cellWidth + dayCellHeight;
              final double top = (startTime.subtract(startTableDuration).hour *
                      (cellWidth + 1)) +
                  (startTime.subtract(startTableDuration).minute *
                      (cellWidth + 1) /
                      60);
              final int maxLine = ((endTime.subtract(startDuration).hour * 60) +
                      (endTime.subtract(startDuration).minute)) ~/
                  30;
              result.add(
                Positioned(
                  top: top,
                  height: height,
                  width: width,
                  child: GestureDetector(
                    onTap: () {
                      onSubjectTap?.call(i);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: i.color,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      i.name,
                                      style: tinyStyle.copyWith(
                                          color: Palette.pureWhite),
                                      maxLines: maxLine,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      i.times.map((e) => e.place).toSet().join(', '),
                                      style: TextStyle(
                                        color: Palette.pureWhite,
                                        fontSize: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
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
                ),
              );
            }
          }
        }
      }
      return result;
    }

    List<Widget> buildDayColumn(int index, List<String> week, int columnLength,
        double cellWidth, double dayCellHeight) {
      return [
        const VerticalDivider(
          color: Colors.grey,
          width: 1,
        ),
        Expanded(
          child: Column(
            children: [
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              SizedBox(
                height: dayCellHeight,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      ...List.generate(
                        columnLength * 2,
                        (index) {
                          if (index % 2 == 0) {
                            return const Divider(
                              color: Colors.grey,
                              height: 1,
                            );
                          }
                          return SizedBox(
                            height: cellWidth,
                          );
                        },
                      ),
                    ],
                  ),
                  ...buildColumnSubjects(
                      index, schedules, dayCellHeight, cellWidth)
                ],
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              SizedBox(
                height: dayCellHeight,
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              )
            ],
          ),
        ),
      ];
    }

    List<Widget> table = [
      buildTimeColumn(dayCellHeight, cellHeight, columnLength)
    ];

    for (String i in week) {
      table = table +
          buildDayColumn(
              week.indexOf(i), week, columnLength, cellHeight, dayCellHeight);
    }

    // TODO: implement build
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 35,
                  ),
                  ...List.generate(
                    week.length,
                    (index) {
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: index == today
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  // You can use like this way or like the below line
                                  //borderRadius: new BorderRadius.circular(30.0),
                                  color: Palette.blue,
                                )
                              : const BoxDecoration(),
                          child: Center(
                            child: Text(
                              week[index],
                              style: regularStyle.copyWith(
                                  color: index == today
                                      ? Palette.pureWhite
                                      : Palette.grey),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(children: table),
            ),
          ],
        ),
        if(isLoading) const Padding(
          padding: EdgeInsets.only(top: 250),
          child: Center(
            child: SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }
}
