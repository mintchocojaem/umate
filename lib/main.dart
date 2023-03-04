import 'package:danvery/app/bindings/login_binding.dart';
import 'package:danvery/app/ui/theme/app_theme.dart';
import 'package:danvery/routes/app_pages.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controller/login_controller.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    onReady: (){
      final loginController = Get.find<LoginController>();
      if(!loginController.isLogin){
        Get.toNamed(Routes.login);
      }
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
