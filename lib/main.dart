import 'package:danvery/pages/home.dart';
import 'package:danvery/palette/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
      home: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: page,
            children: [
              Home(),
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
      ),
    );
  }

}
