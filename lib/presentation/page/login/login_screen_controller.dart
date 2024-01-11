import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';

final loginScreenControllerProvider =
    Provider.autoDispose<LoginScreenController>(
  (ref) => LoginScreenController(
    ref: ref,
  ),
);

class LoginScreenController {
  final Ref ref;

  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreenController({
    required this.ref,
  });

  String? checkStudentId(String? value) {
    if (value == null || value.isEmpty) {
      return '학번을 입력해주세요';
    }
    return null;
  }

  String? checkPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final String studentId = studentIdController.text;
    final String password = passwordController.text;
    await ref.read(tokenProvider.notifier).login(studentId, password);
  }

  void pushLoginHelpPage() {
    ref.read(routerProvider).push(RouteInfo.loginHelp.fullPath);
  }

  void pushSignUpPage() {
    ref.read(routerProvider).push(RouteInfo.signUpVerifyStudent.fullPath);
  }

  void pushSignUpAgreementPage() {
    ref.read(routerProvider).push(RouteInfo.signUpAgreement.fullPath);
  }
}
