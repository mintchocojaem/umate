import 'package:danvery/utils/app_text_theme.dart';
import 'package:danvery/utils/app_theme.dart';
import 'package:danvery/utils/notification.dart';
import 'package:danvery/widgets/modern/modern_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orb/orb.dart';
import 'firebase_options.dart';

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

  Orb().init();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Danvery',
      theme: AppTheme().lightThemeData,
      darkTheme: AppTheme().darkThemeData,
      themeMode: ThemeMode.light,
      home: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danvery',
          style: appTextTheme.labelLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: ModernButton(
            style: ModernButtonStyle.filled,
            onPressed: () {
              showModernDialog(
                title: "소비 내역 더 불러오기",
                content: "소비 내역을 더 불러오시겠습니까?",
                context: context,
                modernButtons: [
                  ModernButton(
                    mode: ModernButtonMode.fullWith,
                    style: ModernButtonStyle.tonal,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    text: '더 불러오기',
                  ),
                ],
              );
            },
            text: '소비 내역 더 불러오기',
          ),
        ),
      ),
    );
  }
}
