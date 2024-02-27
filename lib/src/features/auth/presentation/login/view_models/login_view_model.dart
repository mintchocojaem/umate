import 'dart:async';

import 'package:flutter/cupertino.dart';
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

    final link = ref.keepAlive();

    state = await _loginUseCase(
      params: LoginParams(
        studentId: studentId,
        password: password,
      ),
    );

    if (state.hasError) {
      link.close();
    }
  }

  void goToSignUp() {
    ref.read(routerServiceProvider).push(const VerifyStudentRoute());
  }

  void goToLoginHelp() {
    ref.read(routerServiceProvider).push(const LoginHelpRoute());
  }
}
