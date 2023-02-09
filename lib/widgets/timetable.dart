import 'package:danvery/palette/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Timetable extends StatefulWidget{
  const Timetable({super.key});

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
    final double firstCellWidth = (width / 8) / 2;
    final double cellWidth = (width - (width / 8)) / 7;
    const int columnLength = 8;
    List<String> week = ['월', '화', '수', '목', '금'];

    List<Widget> column = [buildTimeColumn(firstCellWidth, cellWidth, columnLength)];

    for(int i = 0; i < 5; i++){
      column = column + buildDayColumn(i, week, columnLength, cellWidth,firstCellWidth);
    }

    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: column
        ),
      ),
    );
  }

  Expanded buildTimeColumn(double firstCellWidth, double cellWidth, int columnLength) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: firstCellWidth,
          ),
          ...List.generate(
            columnLength*2,
                (index) {
              if (index % 2 == 0) {
                return const Divider(
                  color: Colors.grey,
                  height: 0,
                );
              }
              return SizedBox(
                height: cellWidth,
                child: Center(child: Text('${index ~/ 2 + 9}')),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> buildDayColumn(int index, List<String> week, int columnLength, double cellWidth, double firstCellWidth) {
    return [
      const VerticalDivider(
        color: Colors.grey,
        width: 0,
      ),
      Flexible(
        flex: 4,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: firstCellWidth,
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
            )
          ],
        ),
      ),
    ];
  }

}
