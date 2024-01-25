part of 'verify_student_screen.dart';

mixin class VerifyStudentScreenEvent {
  String? checkStudentId({required String? studentId}) {
    if (studentId == null || studentId.isEmpty) {
      return '학번을 입력해주세요';
    }
    return null;
  }

  String? checkPassword({required String? password}) {
    if (password == null || password.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    return null;
  }

  void agreePolicy(WidgetRef ref) {
    ref.read(routerProvider).pushNamed(AppRoute.signUpAgreePolicy.name);
  }

  Color getAgreedPolicyColor({required bool agreePolicy}) {
    if (agreePolicy) {
      return Colors.green;
    }
    return Colors.grey;
  }

  Future<void> verifyStudent(
    WidgetRef ref, {
    required GlobalKey<FormState> formKey,
    required TextEditingController dkuStudentIdController,
    required TextEditingController dkuPasswordController,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (!ref.read(agreePolicyProvider)) {
      return;
    }

    await ref.read(signUpProvider.notifier).verifyStudent(
          dkuStudentId: dkuStudentIdController.text,
          dkuPassword: dkuPasswordController.text,
        );
  }
}
