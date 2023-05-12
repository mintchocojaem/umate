import 'package:danvery/modules/orb/orbs/blue_flame_orb/widgets/dash_board/orb_list_board.dart';
import 'package:danvery/utils/notification.dart';
import 'package:danvery/modules/orb/orbs/blue_flame_orb/widgets/orb_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'modules/orb/orb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GetStorage.init(); //setupFlutterNotification 보다 먼저 초기화 되어야 함

  // setting 함수
  await setupFlutterNotifications();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  // background 수신처리

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final Orb blueFlameOrb =
      Orb.ofType(OrbType.blueFlame, brightness: Brightness.dark);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Danvery',
      theme: blueFlameOrb.lightThemeData,
      darkTheme: blueFlameOrb.darkThemeData,
      themeMode: blueFlameOrb.themeMode,
      home: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: OrbAppbar(
        leading: themeData.brightness == Brightness.light
            ? Image.asset(
                'assets/icons/app/danvery_light.png',
                width: 48,
                height: 48,
              )
            : Image.asset(
                'assets/icons/app/danvery_dark.png',
                width: 48,
                height: 48,
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              OrbListBoard(
                title: "자유게시판",
                tiles: [
                  CompactTile(title: "방금 전", body: "안녕하세요 총학생회입니다"),
                  CompactTile(title: "방금 전", body: "안녕하세요 총학생회입니다"),
                  CompactTile(title: "방금 전", body: "안녕하세요 총학생회입니다"),
                  CompactTile(title: "11시간 전", body: "안녕하세요 총학생회입니다"),
                  CompactTile(title: "2020/02/23", body: "안녕하세요 총학생회입니다"),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              OrbListBoard(
                title: "청원게시판",
                tiles: [
                  CompactTile(title: "방금 전", body: "안녕하세요 총학생회입니다"),
                  CompactTile(title: "방금 전", body: "안녕하세요 총학생회입니다"),
                  CompactTile(title: "방금 전", body: "안녕하세요 총학생회입니다"),
                  CompactTile(title: "11시간 전", body: "안녕하세요 총학생회입니다"),
                  CompactTile(title: "2020/02/23", body: "안녕하세요 총학생회입니다"),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              OrbButton(
                style: OrbButtonStyle.filled,
                onPressed: () {
                  showModernDialog(
                    title: "소비 내역 더 불러오기",
                    content: "소비 내역을 더 불러오시겠습니까?",
                    context: context,
                    modernButtons: [
                      OrbButton(
                        mode: OrbButtonMode.fullWith,
                        style: OrbButtonStyle.tonal,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: '닫기',
                      ),
                    ],
                  );
                },
                text: '안녕하세요',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
