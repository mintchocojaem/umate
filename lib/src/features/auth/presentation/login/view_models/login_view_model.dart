import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/router_service.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/models/token_model.dart';
import '../../../domain/use_cases/login_use_case.dart';

final loginViewModelProvider =
    AsyncNotifierProvider.autoDispose<LoginViewModel, TokenModel>(
  () => LoginViewModel(),
);

class LoginViewModel extends AutoDisposeAsyncNotifier<TokenModel> {
  KeepAliveLink? _link;

  late final LoginUseCase _loginUseCase;

  @override
  FutureOr<TokenModel> build() {
    final authRepository = ref.watch(authRepositoryImplProvider);
    _loginUseCase = LoginUseCase(
      authRepository: authRepository,
    );
    return future;
  }

  Future<void> login(
    GlobalKey<FormState> formKey, {
    required String studentId,
    required String password,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _link ??= ref.keepAlive();

    state = await _loginUseCase(
      params: LoginParams(
        studentId: studentId,
        password: password,
      ),
    );

    if(state.hasError){
      _link?.close();
    }

  }

  void pushToSignUpScreen() {
    ref.read(routerServiceProvider).push(const VerifyStudentRoute());
  }

  void replaceToSignUpScreen() {
    ref.read(routerServiceProvider).replace(const VerifyStudentRoute());
  }

  void pushToLoginHelpScreen() {
    ref.read(routerServiceProvider).push(const LoginHelpRoute());
  }
}
