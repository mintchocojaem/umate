import 'package:danvery/domain/banner/repository/banner_repository.dart';
import 'package:danvery/routes/app_pages.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/notification/setup_notification.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // setting 함수
  await setupFlutterNotifications();
  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  // background 수신처리

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GetStorage.init();

  runApp(
    GetMaterialApp(
      initialRoute: Routes.splashScreen,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      darkTheme: ThemeData(
        brightness: Brightness.light,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
    ),
  );
}
