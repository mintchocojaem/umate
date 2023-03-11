import 'dart:io';

import 'package:danvery/app/bindings/login_binding.dart';
import 'package:danvery/app/ui/theme/app_theme.dart';
import 'package:danvery/routes/app_pages.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controller/login_controller.dart';
import 'app/notification/setup_notification.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // setting 함수
  await setupFlutterNotifications();
  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  // background 수신처리

  runApp(GetMaterialApp(
    onReady: (){
      final loginController = Get.find<LoginController>();
      if(!loginController.isLogin){
        Get.toNamed(Routes.login);
      }

      FirebaseMessaging.instance.getToken().then((value) {
        //debug mode print
        if (kDebugMode) {
          print("FCM Token : $value");
        }
      });

    },
    initialBinding: LoginBinding(),
    initialRoute: Routes.login,
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

