import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../palette/palette.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }

}

class _Home extends State<Home>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16,bottom: 16,right: 16, left: 16),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                onPressed: () {  },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32, top: 8,bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("버스",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                    Row(
                      children: [
                        Text("버스 더보기",style: TextStyle(fontSize: 14),),
                        Icon(Icons.arrow_forward_ios_outlined,color: Palette.grey,size: 14,)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        title: Text("720-3"),
                        subtitle: Text("단국대학교 곰상 승차"),
                        leading: Icon(Icons.directions_bus),
                        trailing: Text("17분 후 도착"),
                      );
                    }
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32, top: 8,bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("실시간 인기글",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                    Row(
                      children: [
                        Text("게시글 더보기",style: TextStyle(fontSize: 14),),
                        Icon(Icons.arrow_forward_ios_outlined,color: Palette.grey,size: 14,)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        title: Text("새로운 총학생회 부원을 뽑습니다."),
                        subtitle: Text("익명"),
                      );
                    }
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32,top: 8,bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("자유 게시판",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                    Row(
                      children: [
                        Text("게시글 더보기",style: TextStyle(fontSize: 14),),
                        Icon(Icons.arrow_forward_ios_outlined,color: Palette.grey,size: 14,)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        title: Text("새로운 총학생회 부원을 뽑습니다."),
                        subtitle: Text("익명"),
                      );
                    }
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
