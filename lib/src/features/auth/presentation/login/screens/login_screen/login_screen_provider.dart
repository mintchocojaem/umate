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

  void goVerifyStudentScreen(WidgetRef ref) {
    ref.read(appRouterProvider).push(const VerifyStudentRoute());
  }

  void goLoginHelpScreen(WidgetRef ref) {
    ref.read(appRouterProvider).push(const LoginHelpRoute());
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
