part of 'login_help_screen.dart';

mixin class LoginHelpScreenController{

  void goVerifyStudentScreen(WidgetRef ref){
    ref.read(appRouterProvider).replace(const VerifyStudentRoute()) ;
  }

}