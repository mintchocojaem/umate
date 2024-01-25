part of 'login_screen.dart';

mixin class LoginScreenEvent {

  String? validateStudentId({String? studentId}) {
    if (studentId == null || studentId.isEmpty) {
      return '학번을 입력해주세요';
    }
    if (studentId.length != 8) {
      return '학번은 8자리의 숫자에요';
    }
    return null;
  }

  String? validatePassword({String? password}) {
    if (password == null || password.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    return null;
  }

  void pushVerifyStudentPage(WidgetRef ref) {
    ref.read(routerProvider).pushNamed(AppRoute.signUpVerifyStudent.name);
  }

  void pushLoginHelpPage(WidgetRef ref) {
    ref.read(routerProvider).pushNamed(AppRoute.loginHelp.name);
  }

  Future<void> login(
    WidgetRef ref, {
    required GlobalKey<FormState> formKey,
    required TextEditingController studentIdController,
    required TextEditingController passwordController,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await ref.read(tokenProvider.notifier).login(
          studentId: studentIdController.text,
          password: passwordController.text,
        );
  }
}
