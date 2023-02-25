import 'package:danvery/app/ui/theme/app_colors.dart';
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import '../../data/dto/board_list_dto.dart';

class BoardList extends StatefulWidget{

  final List<BoardListDTO> data;
  final String title;
  final String actionTitle;
  final bool showAction;

  const BoardList({super.key, required this.data, required this.title, required this.actionTitle, this.showAction = true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BoardList();
  }

}

class _BoardList extends State<BoardList>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20, top: 20,bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: titleStyle,),
                Row(
                  children: [
                    Text(widget.actionTitle,style: regularStyle.copyWith(color: grey),),
                    widget.showAction ? Icon(Icons.arrow_forward_ios_outlined, color: grey, size: regularStyle.fontSize,) :
                        Container()
                  ],
                ),
              ],
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemCount: widget.data.length,
                itemBuilder: (BuildContext context, int index) {

                  String title = widget.data[index].title;
                  String? leadingImagePath = widget.data[index].leadingImagePath;
                  String? leadingText = widget.data[index].leadingText;
                  String? trailingText = widget.data[index].trailingText;

                  return ListTile(
                    contentPadding: EdgeInsets.all(0),
                    visualDensity: VisualDensity(vertical: -3),
                    dense: true,
                    title: SizedBox(
                        height: 24,
                        child: Text(title,style: regularStyle)
                    ),
                    leading: leadingImagePath == null ? leadingText == null ? Container() :
                    SizedBox(height: 24, child: Text(leadingText, style: regularStyle.copyWith(color: grey),)) :
                    SizedBox(height: 32, width: 32, child: Image.asset(leadingImagePath)), trailing: trailingText == null ? const SizedBox() :
                    Text(trailingText, style: regularStyle,),
                  );
                }
            )
          ],
        ),
      ),
    );
  }

}
