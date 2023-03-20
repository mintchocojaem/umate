import 'package:danvery/routes/app_pages.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/utils/notification/setup_notification.dart';
import 'package:danvery/utils/permission/binding/permission_binding.dart';
import 'package:danvery/utils/permission/service/permission_service.dart';
import 'package:danvery/utils/theme/app_theme.dart';
import 'package:danvery/ui/pages/splash_screen_page/bindings/splash_screen_page_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

void main() async{

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

  runApp(GetMaterialApp(
    initialBinding: SplashScreenPageBinding(),
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
  ));

}

