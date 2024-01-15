import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract base class ScreenController {
  final Ref ref;

  ScreenController({
    required this.ref,
  }){
    init();
  }

  void init(){
    //todo: implement init
  }

}