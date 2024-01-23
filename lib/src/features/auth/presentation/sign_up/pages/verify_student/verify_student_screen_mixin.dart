import 'dart:async';

import 'package:danvery/src/features/auth/presentation/presentation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin VerifyStudentScreenMixin {
  final TextEditingController dkuStudentIdController = TextEditingController();
  final TextEditingController dkuPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  void agreePrivacyPolicy(WidgetRef ref) {
    ref.read(agreePolicyProvider.notifier).update((state) => true);
  }

  Color getAgreePrivacyPolicyColor(WidgetRef ref) {
    if (ref.watch(agreePolicyProvider)) {
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
