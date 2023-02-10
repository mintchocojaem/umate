import 'package:danvery/dto/board_list_dto.dart';
import 'package:danvery/dto/bus_list_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../palette/palette.dart';

class BusList extends StatefulWidget{

  final List<BusListDTO> data;
  final String title;
  final String actionTitle;
  final bool showAction;

  const BusList({
    super.key,
    required this.data,
    required this.title,
    required this.actionTitle,
    this.showAction = true,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BusList();
  }

}

class _BusList extends State<BusList>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 8,bottom: 8),
      child: Container(
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
                  Text(widget.title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                  Row(
                    children: [
                      Text(widget.actionTitle,style: TextStyle(fontSize: 15, color: Palette.grey),),
                      widget.showAction ? Icon(Icons.arrow_forward_ios_outlined,color: Palette.grey,size: 15,) :
                          Container()
                    ],
                  ),
                ],
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemCount: widget.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(0),
                      visualDensity: VisualDensity(vertical: -2),
                      dense: true,
                      title: SizedBox(height: 24,child: Text(widget.data[index].station, style: TextStyle(fontSize: 14))),
                      leading: SizedBox(
                          width: 32,
                          height: 32,
                          child: Image.asset(widget.data[index].imagePath)
                      ),
                      trailing: SizedBox(height: 24,child: Text("${widget.data[index].arrivalTime}분 후 도착", style: TextStyle(fontSize: 14))),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

}
