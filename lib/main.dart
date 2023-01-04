import 'dart:convert';

import 'package:danvery/model/login_info.dart';
import 'package:danvery/pages/home.dart';
import 'package:danvery/palette/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

const apiHost = 'https:/api.dku54play.site';
  //'http://133.186.150.61:8080'
  //'https:/api.dku54play.site'
void main() {
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
                style: TextStyle(fontSize: 15,color: Palette.dark),
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
                      Home(loginInfo: snapshot.data!),
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
        body: '''{\n        "classId":"20220914",\n        "password":"p@ssw0rdplay54!@"\n}''',
    );

    if(loginInfoResponse.statusCode == 200){
      print(loginInfoResponse.statusCode);
      final loginInfoParsed = json.decode(loginInfoResponse.body);
      final LoginInfo loginInfo = LoginInfo.formJson(loginInfoParsed);

      /*http.Response userInfoResponse = await http.get(
        Uri.parse('$apiHost/api/users/major'),
        headers: {"Content-Type": "application/json"},
        body: '''{\n        "classId":"20220914",\n        "password":"p@ssw0rdplay54!@"\n}''',
      );

       */
      //final userInfoParsed = json.decode(userInfoResponse.body);
      //print(userInfoResponse.body);
      return loginInfo;
    }

    return null;
  }

}
