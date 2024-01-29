part of 'verify_student_screen.dart';

mixin class VerifyStudentScreenController{

  void agreePolicy(WidgetRef ref) {
    ref.read(routerProvider).pushNamed(AppRoute.signUpAgreePolicy.name);
  }

  Color agreePolicyIconColor(WidgetRef ref) {
    if (ref.watch(agreePolicyProvider)) {
      return Colors.green;
    }
    return Colors.grey;
  }

  Future<void> verifyStudent(
    WidgetRef ref, {
    required GlobalKey<FormState> formKey,
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!ref.read(agreePolicyProvider)) {
      OrbSnackBar.show(
        type: OrbSnackBarType.warning,
        message: '개인정보 이용약관에 동의가 필요해요',
      );
      return;
    }

    await ref.read(signUpProvider.notifier).verifyStudent(
          dkuStudentId: dkuStudentId,
          dkuPassword: dkuPassword,
        );
  }
}
