import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:danvery/model/login_model.dart';
import 'package:danvery/model/subject_model.dart';
import 'package:danvery/model/user_model.dart';
import 'package:danvery/pages/home_page.dart';
import 'package:danvery/pages/login_page.dart';
import 'package:danvery/pages/membership_page.dart';
import 'package:danvery/pages/timetable_page.dart';
import 'package:danvery/pages/board_page.dart';
import 'package:danvery/pages/posting_page.dart';
import 'package:danvery/settings/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

const apiHost = 'https://api.dku54play.site';
//'http://133.186.218.8:8080'
//'https://api.dku54play.site'

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  static UserModel userModel = UserModel(subjects: [
    SubjectModel(
        name: "확률과 통계", startTime: '09:00', endTime: '10:30', days: ["월", "화"]),
    SubjectModel(
        name: "선형 대수", startTime: '11:00', endTime: '12:30', days: ["수"]),
  ], name: "이재민", major: "소프트웨어학과", studentNumber: "32193419");

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
        ),
        home: FutureBuilder<LoginModel?>(
          future: login(),
          builder: (BuildContext context, AsyncSnapshot<LoginModel?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 15),
                ),
              );
            } else if (snapshot.hasData == false) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data == null) {
              return Container();
            } else {
              return SafeArea(
                child: Scaffold(
                  backgroundColor: Palette.white,
                  body: Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: IndexedStack(
                      index: page,
                      children: [
                        //모든 페이지는 SinglechildScrollview로 시작해야함
                        HomePage(
                          loginModel: snapshot.data!,
                          userModel: userModel,
                        ),
                        TimetablePage(userModel: userModel),
                        MembershipPage(),
                        BoardPage(),
                        PostingPage()
                      ],
                    ),
                  ),
                  bottomNavigationBar: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 1),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      child: BottomNavigationBar(
                        onTap: (value) {
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
                            icon: Image.asset(
                              "assets/icons/bottom_nav/home_icon.png",
                              scale: 2,
                            ),
                            label: "홈",
                          ),
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                  "assets/icons/bottom_nav/timetable_icon.png",
                                  scale: 2),
                              label: "시간표"),
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                  "assets/icons/bottom_nav/bus_icon.png",
                                  scale: 2),
                              label: "버스"),
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                  "assets/icons/bottom_nav/board_icon.png",
                                  scale: 2),
                              label: "게시판"),
                          BottomNavigationBarItem(
                              icon: Image.asset(
                                  "assets/icons/bottom_nav/setting_icon.png",
                                  scale: 2),
                              label: "설정"),
                        ],
                      ),
                    ),
                  ),
                  extendBody: true,
                ),
              );
            }
          },
        ));
  }

  Future<LoginModel?> login() async {
    http.Response loginInfoResponse = await http.post(
      Uri.parse('$apiHost/api/users/login'),
      headers: {"Content-Type": "application/json"},
      body:
          '''{\n        "classId":"17011092",\n        "password":"99730567"\n}''',
    );

    if (loginInfoResponse.statusCode == 200) {
      final loginInfoParsed = json.decode(loginInfoResponse.body);
      print(loginInfoParsed);
      final LoginModel loginInfo = LoginModel.formJson(loginInfoParsed);
      return loginInfo;
    }

    return null;
  }
}
