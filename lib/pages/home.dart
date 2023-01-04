import 'dart:convert';

import 'package:danvery/model/login_info.dart';
import 'package:danvery/model/post_info.dart';
import 'package:danvery/model/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../palette/palette.dart';

class Home extends StatefulWidget{
  final LoginInfo loginInfo;

  const Home({super.key, required this.loginInfo});

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
      child: FutureBuilder<List<PostInfo>?>(
        future: getHome(),
        builder: (context, AsyncSnapshot<List<PostInfo>?> snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15,color: Palette.dark),
                ),
              ),
            );
          }else if(snapshot.hasData == false){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.data == null){
            return const Center(child: CircularProgressIndicator());
          }else{
            return Column(
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
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              dense: true,
                              title: Text(snapshot.data![index].title),
                              subtitle: Text("익명"),
                            );
                          }
                      )
                    ],
                  ),
                )
              ],
            );
          }
        }
      ),
    );
  }

  Future<List<PostInfo>?> getHome() async{

    http.Response postInfoResponse = await http.get(
      Uri.parse('$apiHost/api/suggestion?page=0&size=5'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": widget.loginInfo.accessToken
      },
    );
    print(postInfoResponse.statusCode);
    if(postInfoResponse.statusCode == 200){
      final List<PostInfo> postList = json.decode(utf8.decode(postInfoResponse.bodyBytes))["content"]
          .map<PostInfo>((json) => PostInfo.fromJson(json)).toList();
      return postList;
    }

    return null;
  }

}
