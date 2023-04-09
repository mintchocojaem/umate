
import '/core/theme/palette.dart';
import '../../../domain/timetable/model/lecture_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/core/theme/app_text_theme.dart';

class Timetable extends StatelessWidget {
  final List<LectureModel>? subjects;

  final int tableStartTime;
  final int tableEndTime;
  final int today;
  final void Function(LectureModel subjectModel)? onSubjectTap;

  const Timetable({
    super.key,
    required this.subjects,
    required this.tableStartTime,
    required this.tableEndTime,
    this.today = 0,
    this.onSubjectTap,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double cellHeight = (width - (width / 8)) / 7;
    final double dayCellHeight = cellHeight / 2;

    int columnLength = tableEndTime - tableStartTime;

    List<String> week = ['월', '화', '수', '목', '금'];

    List<Widget> table = [
      buildTimeColumn(dayCellHeight, cellHeight, columnLength)
    ];

    for (String i in week) {
      List<LectureModel> temp = [];

      if (subjects != null) {
        for (LectureModel s in subjects!) {
          for (String j in s.days) {
            if (j == i) {
              temp.add(s);
            }
          }
        }
      }

      table = table +
          buildDayColumn(week.indexOf(i), week, columnLength, cellHeight,
              dayCellHeight, temp);
    }

    // TODO: implement build
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: Row(
            children: [
              SizedBox(
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
                      )),
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
    );
  }

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

  List<Widget> buildDayColumn(int index, List<String> week, int columnLength,
      double cellWidth, double dayCellHeight, List<LectureModel>? subjects) {
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
                ...buildColumnSubjects(subjects, dayCellHeight, cellWidth)
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

  List<Widget> buildColumnSubjects(
      List<LectureModel>? subjects, double dayCellHeight, double cellWidth) {
    DateTime startTableTime = DateFormat('HH').parse(tableStartTime.toString());
    Duration startTableDuration = Duration(hours: startTableTime.hour);

    List<Widget> result = [];
    if (subjects != null) {
      for (LectureModel i in subjects) {
        DateTime startTime = DateFormat('HH:mm').parse(i.startTime);
        Duration startDuration =
            Duration(hours: startTime.hour, minutes: startTime.minute);

        DateTime endTime = DateFormat('HH:mm').parse(i.endTime);

        result.add(
          Positioned(
            top: (startTime.subtract(startTableDuration).hour * (cellWidth +1)) +
                (startTime.subtract(startTableDuration).minute * (cellWidth+1) / 60),
            height: (endTime.subtract(startDuration).hour * (cellWidth +1)) +
                (endTime.subtract(startDuration).minute * (cellWidth +1) / 60),
            width: cellWidth + dayCellHeight,
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
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                i.name,
                                style:
                                    lightStyle.copyWith(color: Palette.pureWhite),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
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
    return result;
  }
}
