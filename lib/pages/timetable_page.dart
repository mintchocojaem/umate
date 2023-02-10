import 'package:danvery/dto/board_list_dto.dart';
import 'package:danvery/model/subject_model.dart';
import 'package:danvery/model/user_model.dart';
import 'package:danvery/palette/palette.dart';
import 'package:danvery/widgets/board_list.dart';
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

    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          /*
          AppBar(
            title: Text("시간표", style: TextStyle(color: Palette.black),),
            centerTitle: true,
            backgroundColor: Palette.white,
            elevation: 0,
          ),
          */
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          Timetable(subjects: subjects,tableStartTime: 9, tableEndTime: 18,discription: "2023-1",tableName: "시간표1"),
          BoardList(data: [BoardListDTO(leading: "소프트웨어학과", title: "이관현")], title: "친구", actionTitle: "",showAction: false,)
        ],
      ),
    );
  }



}
