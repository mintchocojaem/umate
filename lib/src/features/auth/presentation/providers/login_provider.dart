import 'dart:async';

import 'package:danvery/src/core/utils/async_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../domain/models/token_model.dart';
import '../../domain/use_cases/login_use_case.dart';

final loginProvider =
    NotifierProvider.autoDispose<LoginNotifier, AsyncState<TokenModel>>(
  () => LoginNotifier(),
);

class LoginNotifier extends AutoDisposeNotifier<AsyncState<TokenModel>> {
  late final RouterService _routerService;

  @override
  AsyncState<TokenModel> build() {
    _routerService = ref.read(routerServiceProvider);
    return AsyncState.initial();
  }

  Future<void> login(
    GlobalKey<FormState> formKey, {
    required String studentId,
    required String password,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    state = AsyncState.loading();

    state = await ref.read(loginUseCaseProvider)(
      LoginParams(
        studentId: studentId,
        password: password,
      ),
    );
  }

  void pushToSignUpScreen() {
    _routerService.push(const SignUpVerifyStudentRoute());
  }

  void replaceToSignUpScreen() {
    _routerService.replace(const SignUpVerifyStudentRoute());
  }

  void pushToLoginHelpScreen() {
    _routerService.push(const LoginHelpRoute());
  }
}
