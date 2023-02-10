import 'dart:convert';

import 'package:danvery/model/login_model.dart';
import 'package:danvery/model/petition_model.dart';
import 'package:danvery/model/post_model.dart';
import 'package:danvery/model/user_model.dart';
import 'package:danvery/widgets/board_list.dart';
import 'package:danvery/widgets/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dto/board_list_dto.dart';
import '../main.dart';
import '../palette/palette.dart';

class HomePage extends StatefulWidget{
  final LoginModel loginModel;
  final UserModel userModel;

  const HomePage({super.key, required this.loginModel, required this.userModel});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }

}

class _HomePage extends State<HomePage>{

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return SingleChildScrollView(
      child: FutureBuilder<Map<String,List?>>(
        future: getHome(),
        builder: (context, AsyncSnapshot<Map<String,List?>> snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15)
                ),
              ),
            );
          }else if(snapshot.hasData == false){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.data == null){
            return const Center(child: CircularProgressIndicator());
          }else{
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: height * 0.4,
                      color: Palette.blue,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.05, left:  width * 0.1, right:  width * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(color: Palette.white),
                                    text: '안녕하세요,\n', // default text style
                                    children: <TextSpan>[
                                      TextSpan(text: "${widget.userModel.major} ${widget.userModel.studentNumber.substring(2,4)}학번\n",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                      TextSpan(text: '${widget.userModel.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                      const TextSpan(text: " 님")
                                    ],
                                  ),
                                ),
                                /*
                                CircleAvatar(
                                  backgroundColor: Palette.white,
                                  minRadius: 30,
                                  child: Image.asset("assets/icons/main_header/bear_icon.png",scale: 1.5,),
                                )
                                 */
                              ],
                            ),
                            SizedBox(height: height * 0.03,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainButton(
                                  imagePath: "assets/icons/main_btn_list/school_home_btn.png",
                                  text: "학교 홈",
                                  onPressed: (){
                                  },
                                ),
                                MainButton(
                                  imagePath: "assets/icons/main_btn_list/reading_room_btn.png",
                                  text: "열람실",
                                  onPressed: (){
                                  },
                                ),
                                MainButton(
                                  imagePath: "assets/icons/main_btn_list/web_info_btn.png",
                                  text: "웹 정보",
                                  onPressed: (){
                                  },
                                ),
                                MainButton(
                                  imagePath: "assets/icons/main_btn_list/school_schedule_btn.png",
                                  text: "학사일정",
                                  onPressed: (){
                                  },
                                ),
                                MainButton(
                                  imagePath: "assets/icons/main_btn_list/students_council_btn.png",
                                  text: "총학생회\nVOC",
                                  onPressed: (){
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: height * 0.3),
                    Padding(
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
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("버스 정보",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                  Row(
                                    children: [
                                      Text("더보기",style: TextStyle(fontSize: 14,color: Palette.grey),),
                                      Icon(Icons.arrow_forward_ios_outlined,color: Palette.grey,size: 14,)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),
                              ListTile(
                                dense: true,
                                title: Text("단국대학교 정문 승차"),
                                leading: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: Image.asset("assets/icons/bus_list/bus_102.png")
                                ),
                                trailing: Text("17분 후 도착"),
                              ),
                              ListTile(
                                dense: true,
                                title: Text("단국대학교 정문 승차"),
                                leading: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: Image.asset("assets/icons/bus_list/bus_720_3.png")
                                ),
                                trailing: Text("17분 후 도착"),
                              ),
                              ListTile(
                                dense: true,
                                title: Text("단국대학교 정문 승차"),
                                leading: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: Image.asset("assets/icons/bus_list/bus_24.png")
                                ),
                                trailing: Text("17분 후 도착"),
                              ),
                              ListTile(
                                dense: true,
                                title: Text("단국대학교 정문 승차"),
                                leading: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: Image.asset("assets/icons/bus_list/bus_school.png")
                                ),
                                trailing: Text("17분 후 도착"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BoardList(
                        title: "자유게시판",
                        actionTitle: "더보기",
                        data: getBoardList(snapshot.data!["freeBoard"])
                    ),
                    BoardList(
                      title: "청원게시판",
                      actionTitle: "더보기",
                      data: getBoardList(snapshot.data!["petitionBoard"]),
                    ),
                  ],
                ),
              ],
            );
          }
        }
      ),
    );
  }

  Future<Map<String,List?>> getHome() async{

    Map<String,List?> postList = {
      "freeBoard": await getFreeBoard(),
      "petitionBoard": await getPetitionBoard()
    };

    return postList;
  }

  Future<List<PostModel>?> getFreeBoard() async {
    http.Response postInfoResponse = await http.get(
      Uri.parse('$apiHost/api/suggestion?page=0&size=5&sort=createDate,desc'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": widget.loginModel.accessToken
      },
    );

    print(postInfoResponse.statusCode);
    if(postInfoResponse.statusCode == 200){
      final List<PostModel> response = json.decode(utf8.decode(postInfoResponse.bodyBytes))["content"]
          .map<PostModel>((json) => PostModel.fromJson(json)).toList();
      return response;
    }
    return null;
  }

  Future<List<PetitionModel>?> getPetitionBoard() async {
    http.Response petitionInfoResponse = await http.get(
      Uri.parse('$apiHost/api/petition/'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": widget.loginModel.accessToken
      },
    );

    print(petitionInfoResponse.statusCode);
    if(petitionInfoResponse.statusCode == 200){
      //print(json.decode(utf8.decode(postInfoResponse.bodyBytes))["content"]);
      final List<PetitionModel> response = json.decode(utf8.decode(petitionInfoResponse.bodyBytes))["content"]
          .map<PetitionModel>((json) => PetitionModel.fromJson(json)).toList();
      return response;
    }
    return null;
  }

  List<BoardListDTO> getBoardList(dynamic data){

    List<BoardListDTO> result = [];
    for(dynamic i in data){
      result.add(BoardListDTO(leading: "익명", title: i.title));
    }
    return result;
  }

}
