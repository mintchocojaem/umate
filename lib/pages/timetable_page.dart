import 'package:danvery/model/subject_model.dart';
import 'package:danvery/model/user_model.dart';
import 'package:danvery/palette/palette.dart';
import 'package:danvery/widgets/timetable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimetablePage extends StatefulWidget{

  final UserModel userModel;

  const TimetablePage({super.key, required this.userModel});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TimetablePage();
  }

}

class _TimetablePage extends State<TimetablePage>{

  @override
  Widget build(BuildContext context) {

    final List<SubjectModel>? subjects = widget.userModel.subjects;

    final double height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Container(
      color: Palette.white,
      child: Column(
        children: [
          AppBar(
            title: Text("시간표", style: TextStyle(color: Palette.black),),
            centerTitle: true,
            backgroundColor: Palette.white,
            elevation: 0,
          ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Timetable(subjects: subjects,tableStartTime: 9, tableEndTime: 18,),
         )
        ],
      ),
    );
  }



}
