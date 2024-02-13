import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/configs.dart';
import '../../../../../modules/modules.dart';
import '../../../../features.dart';

mixin class VerifyStudentScreenController {
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

    final bool agreePolicy = ref.read(agreePrivacyPolicyServiceProvider);

    if (!agreePolicy) {
      OrbSnackBar.show(
        type: OrbSnackBarType.warning,
        message: '개인정보 이용약관에 동의가 필요해요',
      );
      return;
    }

    await ref.read(signUpServiceProvider.notifier).verifyStudent(
          dkuStudentId: dkuStudentId,
          dkuPassword: dkuPassword,
        );
  }
}
