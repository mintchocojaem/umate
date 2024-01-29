import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/cupertino.dart';

class OrbService{

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final OrbService _instance = OrbService._internal();

  OrbService._internal();

  factory OrbService(){
    return _instance;
  }

  OrbService.init({GlobalKey<NavigatorState>? newNavigatorKey}){
    if(newNavigatorKey != null){
      navigatorKey = newNavigatorKey;
    }
      OrbSnackBar.init(
      navigatorKey: navigatorKey,
    );
  }

}