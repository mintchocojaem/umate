part of 'verify_student_screen.dart';

mixin class VerifyStudentScreenState{

  bool isAgreedPolicy(WidgetRef ref) {
    return ref.watch(agreePolicyProvider);
  }

}