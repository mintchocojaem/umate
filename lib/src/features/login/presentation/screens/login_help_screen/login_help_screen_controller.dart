part of 'login_help_screen.dart';

mixin class LoginHelpScreenController{

  void pushVerifyStudentPage(WidgetRef ref){
    ref.read(routerProvider).pushReplacementNamed(AppRoute.signUpVerifyStudent.name);
  }

}