import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../presentation.dart';

final loginScreenControllerProvider =
    Provider.autoDispose<_LoginScreenController>(
  (ref) {
    ref.watch(tokenProvider.notifier);
    return _LoginScreenController(
      ref: ref,
    );
  },
);

final class _LoginScreenController extends ScreenController {
  _LoginScreenController({
    required super.ref,
  });

  final TextEditingController _studentIdController = TextEditingController();
  TextEditingController get studentIdController => _studentIdController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final List<CancelToken> _cancelTokens = [];

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

    final CancelToken cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    final String studentId = studentIdController.text;
    final String password = passwordController.text;
    await ref.read(tokenProvider.notifier).login(
          cancelToken,
          studentId: studentId,
          password: password,
        );
  }

  void _cancelAllRequests() {
    if (_cancelTokens.isNotEmpty) {
      for (var cancelToken in _cancelTokens) {
        cancelToken.cancel();
      }
    }
  }

  void pushLoginHelpPage() {
    _cancelAllRequests();
    ref.read(routerProvider).push(RouteInfo.loginHelp.fullPath);
  }

  void pushSignUpPage() {
    _cancelAllRequests();
    ref.read(routerProvider).push(RouteInfo.signUpVerifyStudent.fullPath);
  }

}
