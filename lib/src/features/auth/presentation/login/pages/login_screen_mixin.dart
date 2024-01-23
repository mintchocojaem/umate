import 'package:danvery/src/features/auth/presentation/presentation.dart';
import 'package:danvery/src/route/app_route.dart';
import 'package:danvery/src/route/router_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin LoginScreenMixin {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateStudentId({String? studentId}) {
    if (studentId == null || studentId.isEmpty) {
      return '학번을 입력해주세요';
    }
    if (studentId.length != 8) {
      return '학번은 8자리의 숫자에요';
    }
    return null;
  }

  String? validatePassword({String? password}) {
    if (password == null || password.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    return null;
  }

  void pushSignUpVerifyStudent(WidgetRef ref) {
    ref.read(routerProvider).pushNamed(AppRoute.signUpVerifyStudent.name);
  }

  Future<void> login(
    WidgetRef ref, {
    required GlobalKey<FormState> formKey,
    required TextEditingController studentIdController,
    required TextEditingController passwordController,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await ref.read(tokenProvider.notifier).login(
          studentId: studentIdController.text,
          password: passwordController.text,
        );
  }
}
