import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:danvery/model/login_info.dart';
import 'package:danvery/model/user_info.dart';
import 'package:danvery/pages/home_page.dart';
import 'package:danvery/pages/timetable_page.dart';
import 'package:danvery/palette/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

const apiHost = 'https://api.dku54play.site';
  //'http://133.186.218.8:8080'
  //'https://api.dku54play.site'

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp>{

  int page = 0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Palette.dark,
          selectedItemColor: Palette.dark,
        ),
        iconTheme: IconThemeData(
            color: Palette.dark,
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(fontSize: 14),
        ),
      ),
      home: FutureBuilder<LoginInfo?>(
        future: login(),
        builder: (BuildContext context, AsyncSnapshot<LoginInfo?> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 15),
              ),
            );
          }else if(snapshot.hasData == false){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.data == null){
            return Container();
          }else{
            return SafeArea(
              child: Scaffold(
                backgroundColor: Palette.white,
                body: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.08),
                  child: IndexedStack(
                    index: page,
                    children: [
                      HomePage(
                        loginInfo: snapshot.data!,
                        userInfo: UserInfo(name: "이재민", major: "소프트웨어학과",studentNumber: "32193419"),
                      ),
                      TimetablePage(

                      )
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 1),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                    ),
                    child: BottomNavigationBar(
                      onTap: (value){
                        setState(() {
                          page = value;
                        });
                      },
                      //currentIndex: page,
                      backgroundColor: Palette.white,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      items: [
                        BottomNavigationBarItem(
                          icon: Image.asset("assets/icons/bottom_nav/home_icon.png",scale: 2,),
                          label: "홈",
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset("assets/icons/bottom_nav/timetable_icon.png",scale: 2),
                          label: "시간표"
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset("assets/icons/bottom_nav/bus_icon.png",scale: 2),
                          label: "버스"
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset("assets/icons/bottom_nav/board_icon.png",scale: 2),
                          label: "게시판"
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset("assets/icons/bottom_nav/setting_icon.png",scale: 2),
                          label: "설정"
                        ),
                      ],
                    ),
                  ),
                ),
                extendBody: true,
              ),
            );
          }
        },
      )
    );
  }

  Future<LoginInfo?> login() async {
    http.Response loginInfoResponse = await http.post(
        Uri.parse('$apiHost/api/users/login'),
        headers: {"Content-Type": "application/json"},
        body: '''{\n        "classId":"17011092",\n        "password":"99730567"\n}''',
    );

    if(loginInfoResponse.statusCode == 200){
      print(loginInfoResponse.statusCode);
      final loginInfoParsed = json.decode(loginInfoResponse.body);
      final LoginInfo loginInfo = LoginInfo.formJson(loginInfoParsed);
      return loginInfo;
    }

    return null;
  }

}
