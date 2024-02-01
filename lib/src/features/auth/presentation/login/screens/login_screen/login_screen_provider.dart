part of 'login_screen.dart';

final loginScreenProvider =
    NotifierProvider.autoDispose<LoginScreenNotifier, LoginScreenState>(
  () => LoginScreenNotifier(),
);

class LoginScreenState {}

class LoginScreenNotifier extends AutoDisposeNotifier<LoginScreenState> {
  @override
  LoginScreenState build() {
    // TODO: implement build
    return LoginScreenState();
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
    required String studentId,
    required String password,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await ref.read(tokenProvider.notifier).login(
          studentId: studentId,
          password: password,
        );
  }
}
