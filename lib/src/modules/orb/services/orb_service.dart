import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/material.dart';

class OrbService{

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static final OrbService _instance = OrbService._internal();

  OrbService._internal();

  factory OrbService(){
    return _instance;
  }

  OrbService.init(){
    OrbSnackBar.init(
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }

}