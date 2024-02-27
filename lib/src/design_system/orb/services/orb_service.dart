import 'package:flutter/material.dart';

import '../components/snack_bar/orb_snack_bar.dart';

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