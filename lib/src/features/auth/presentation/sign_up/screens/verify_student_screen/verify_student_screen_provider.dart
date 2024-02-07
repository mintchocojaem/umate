part of 'verify_student_screen.dart';

final verifyStudentScreenProvider = NotifierProvider.autoDispose<
    VerifyStudentScreenNotifier, VerifyStudentScreenState>(() {
  return VerifyStudentScreenNotifier();
});

class VerifyStudentScreenState {}

class VerifyStudentScreenNotifier
    extends AutoDisposeNotifier<VerifyStudentScreenState> with AuthValidator {
  @override
  build() {
    // TODO: implement build
    return VerifyStudentScreenState();
  }

  void goAgreePolicyScreen(WidgetRef ref) {
    ref.read(appRouterProvider).push(const AgreePolicyRoute());
  }

  Color agreePolicyIconColor({required bool agreePolicy}) {
    if (agreePolicy) {
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
