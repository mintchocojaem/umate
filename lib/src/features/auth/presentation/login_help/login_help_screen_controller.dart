
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/configs.dart';

mixin class LoginHelpScreenController{

  void goVerifyStudentScreen(WidgetRef ref){
    ref.read(appRouterProvider).replace(const VerifyStudentRoute()) ;
  }

}