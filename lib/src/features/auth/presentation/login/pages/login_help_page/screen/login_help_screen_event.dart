part of 'login_help_screen.dart';

mixin class LoginHelpScreenEvent{

  void pushVerifyStudentPage(WidgetRef ref){
    ref.read(routerProvider).pushReplacementNamed(AppRoute.signUpVerifyStudent.name);
  }

}