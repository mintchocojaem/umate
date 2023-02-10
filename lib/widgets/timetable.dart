import 'dart:math';

import 'package:danvery/model/user_model.dart';
import 'package:danvery/palette/palette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/subject_model.dart';

class Timetable extends StatefulWidget{

  final List<SubjectModel>? subjects;

  final int tableStartTime;
  final int tableEndTime;

  const Timetable({super.key, required this.subjects, required this.tableStartTime, required this.tableEndTime});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Timetable();
  }

}

class _Timetable extends State<Timetable>{

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double cellWidth = (width - (width / 8)) / 7;
    final double dayCellHeight = cellWidth / 2;

    int columnLength = widget.tableEndTime - widget.tableStartTime;

    List<String> week = ['월', '화', '수', '목', '금'];

    List<Widget> table = [buildTimeColumn(dayCellHeight, cellWidth, columnLength)];

    for(String i in week){

      List<SubjectModel> temp = [];

      if(widget.subjects != null){
        for(SubjectModel s in widget.subjects!){
          for(String j in s.days){
            if(j == i){
              temp.add(s);
            }
          }

        }
      }

      table = table + buildDayColumn(week.indexOf(i), week, columnLength, cellWidth,dayCellHeight, temp);

    }

    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: table
        ),
      ),
    );
  }

  Widget buildTimeColumn(double dayCellHeight, double cellWidth, int columnLength) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          SizedBox(
            height: dayCellHeight,
          ),
          ...List.generate(
            columnLength  * 2,
                (index) {
              if (index % 2 == 0) {
                return const Divider(
                  color: Colors.grey,
                  height: 0,
                );
              }
              return SizedBox(
                height: cellWidth,
                child: Center(
                    child: Text(
                      '${(index ~/ 2) + widget.tableStartTime}',
                      style: TextStyle(fontSize: 12),
                    )
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> buildDayColumn(
      int index,
      List<String>
      week,
      int columnLength,
      double cellWidth,
      double dayCellHeight,
      List<SubjectModel>? subjects) {
    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Flexible(
        flex: 3,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: dayCellHeight,
                  child: Text(
                    week[index],
                  ),
                ),
                ...List.generate(
                  columnLength * 2,
                      (index) {
                    if (index % 2 == 0) {
                      return const Divider(
                        color: Colors.grey,
                        height: 0,
                      );
                    }
                    return SizedBox(
                      height: cellWidth,
                      child: Container(),
                    );
                  },
                ),
              ],
            ),
            ...buildColumnSubjects(subjects, dayCellHeight, cellWidth)
          ],
        ),
      ),
    ];
  }

  List<Widget> buildColumnSubjects(List<SubjectModel>? subjects, double dayCellHeight, double cellWidth){

    DateTime startTableTime = DateFormat('HH').parse(widget.tableStartTime.toString());
    Duration startTableDuration = Duration(hours: startTableTime.hour);

    Color randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);

    List<Widget> result = [];
    if(subjects != null){
      for(SubjectModel i in subjects){

        DateTime startTime = DateFormat('HH:mm').parse(i.startTime);
        Duration startDuration = Duration(hours: startTime.hour, minutes: startTime.minute);

        DateTime endTime = DateFormat('HH:mm').parse(i.endTime);

        result.add(
          Positioned(
            top: dayCellHeight
                + (startTime.subtract(startTableDuration).hour * cellWidth)
                + (startTime.subtract(startTableDuration).minute * cellWidth / 60),
            height: (endTime.subtract(startDuration).hour * cellWidth)
                + (endTime.subtract(startDuration).minute * cellWidth / 60),
            width: cellWidth + dayCellHeight,
            child: Container(
              decoration: BoxDecoration(
                color: randomColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text(i.name, style: TextStyle(color: Palette.white, fontSize: 13),),
              ),
            ),
          ),
        );
      }
    }
    return result;
  }

}
