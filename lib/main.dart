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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.notifications_none_rounded),
                  onPressed: () {  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
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
                        itemCount: 5,
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

            ],
          ),
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
