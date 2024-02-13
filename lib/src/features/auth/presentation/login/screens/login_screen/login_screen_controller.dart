import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../config/configs.dart';
import '../../../../../features.dart';

mixin class LoginScreenController {
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

    await ref.read(loginServiceProvider.notifier).login(
          studentId: studentId,
          password: password,
        );
  }
}
