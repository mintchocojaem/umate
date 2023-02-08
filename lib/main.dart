import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:danvery/model/login_info.dart';
import 'package:danvery/model/user_info.dart';
import 'package:danvery/pages/home.dart';
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
        fontFamily: 'NotoSansKR',
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
            return Scaffold(
              body: SafeArea(
                  child: IndexedStack(
                    index: page,
                    children: [
                      Home(
                        loginInfo: snapshot.data!,
                        userInfo: UserInfo(name: "이재민", major: "소프트웨어학과",studentNumber: "32193419"),
                      ),
                    ],
                  )
              ),
              bottomNavigationBar: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "홈"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today),
                      label: "시간표"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bus_alert),
                      label: "버스"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.border_color_rounded),
                      label: "게시판"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: "설정"
                  ),
                ],
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
