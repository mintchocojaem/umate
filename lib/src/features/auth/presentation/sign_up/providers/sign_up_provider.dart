import 'dart:async';

import 'package:danvery/src/core/services/router/router_service.dart';
import 'package:danvery/src/core/utils/async_state.dart';
import 'package:danvery/src/features/auth/domain/use_cases/sign_up_confirm_nickname_use_case.dart';
import 'package:danvery/src/features/auth/domain/use_cases/sign_up_send_code_use_case.dart';
import 'package:danvery/src/features/auth/domain/use_cases/sign_up_compelete_use_case.dart';
import 'package:danvery/src/features/auth/domain/use_cases/sign_up_verify_nickname_use_case.dart';
import 'package:danvery/src/features/auth/domain/use_cases/sign_up_verify_code_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../domain/models/sign_up_info_model.dart';
import '../../../domain/use_cases/sign_up_verify_student_use_case.dart';

final signUpProvider =
    NotifierProvider.autoDispose<SignUpNotifier, AsyncState<SignUpInfoModel>>(
  () => SignUpNotifier(),
);

class SignUpNotifier extends AutoDisposeNotifier<AsyncState<SignUpInfoModel>> {
  late final SignUpVerifyStudentUseCase _signUpVerifyStudentUseCase;
  late final SignUpSendCodeUseCase _signUpSendCodeCodeUseCase;
  late final SignUpVerifyCodeUseCase _signUpVerifyCodeUseCase;
  late final SignUpConfirmNicknameUseCase _signUpConfirmNicknameUseCase;
  late final SignUpVerifyNicknameUseCase _signUpVerifyNicknameUseCase;
  late final SignUpCompleteUseCase _signUpCompleteUseCase;

  late final RouterService _routerService;

  @override
  AsyncState<SignUpInfoModel> build() {
    // TODO: implement build
    _routerService = ref.watch(routerServiceProvider);

    final authRepository = ref.watch(authRepositoryImplProvider);
    _signUpVerifyStudentUseCase = SignUpVerifyStudentUseCase(
      authRepository: authRepository,
    );
    _signUpSendCodeCodeUseCase = SignUpSendCodeUseCase(
      authRepository: authRepository,
    );
    _signUpVerifyCodeUseCase = SignUpVerifyCodeUseCase(
      authRepository: authRepository,
    );
    _signUpVerifyNicknameUseCase = SignUpVerifyNicknameUseCase(
      authRepository: authRepository,
    );
    _signUpConfirmNicknameUseCase = SignUpConfirmNicknameUseCase(
      signUpVerifyNicknameUseCase: _signUpVerifyNicknameUseCase,
    );
    _signUpCompleteUseCase = SignUpCompleteUseCase(
      authRepository: authRepository,
    );
    return AsyncState.initial();
  }

  void _setErrorState(String? message, StackTrace stackTrace) {
    state = state.copyWith(
      hasError: true,
      message: message,
      stackTrace: stackTrace,
    );
  }

  Future<void> verifyStudentFlow(
    GlobalKey<FormState> formKey, {
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    state = AsyncState.loading();

    state = await _signUpVerifyStudentUseCase(
      SignUpVerifyStudentParams(
        dkuStudentId: dkuStudentId,
        dkuPassword: dkuPassword,
      ),
    );

    if (state.hasData) {
      await _routerService.replace(
        SignUpSendCodeRoute(
          signUpToken: state.data!.signUpToken,
          student: state.data!.student,
        ),
      );
    }
  }

  Future<bool> sendCode({
    required String signUpToken,
    required String phoneNumber,
  }) async {
    final result = await _signUpSendCodeCodeUseCase(
      SignUpSendCodeParams(
        signUpToken: signUpToken,
        phoneNumber: phoneNumber,
      ),
    );

    if (result.hasError) {
      _setErrorState(
        result.message,
        result.stackTrace ?? StackTrace.current,
      );
    }

    return result.hasData;
  }

  Future<void> sendCodeFlow(
    GlobalKey<FormState> formKey, {
    required String signUpToken,
    required String phoneNumber,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final result = await sendCode(
      signUpToken: signUpToken,
      phoneNumber: phoneNumber,
    );

    if (result) {
      await _routerService.replace(
        SignUpVerifyCodeRoute(
          signUpToken: signUpToken,
          phoneNumber: phoneNumber,
        ),
      );
    }
  }

  Future<void> verifyCodeFlow(
    GlobalKey<FormState> formKey, {
    required String signUpToken,
    required String code,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final result = await _signUpVerifyCodeUseCase(
      SignUpVerifyCodeParams(
        signUpToken: signUpToken,
        code: code,
      ),
    );

    if (result.hasError) {
      _setErrorState(
        result.message,
        result.stackTrace ?? StackTrace.current,
      );
    } else {
      await _routerService.replace(
        SignUpNicknameRoute(signUpToken: signUpToken),
      );
    }
  }

  Future<bool> verifyNickname(
    GlobalKey<FormState> formKey, {
    required String nickname,
  }) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    final result = await _signUpVerifyNicknameUseCase(
      SignUpVerifyNicknameParams(
        nickname: nickname,
      ),
    );

    if (result.hasError) {
      _setErrorState(
        result.message,
        result.stackTrace ?? StackTrace.current,
      );
    }

    return result.hasData;
  }

  Future<void> confirmNicknameFlow(
    GlobalKey<FormState> formKey, {
    required String signUpToken,
    required String availableNickname,
    required String currentNickname,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final result = await _signUpConfirmNicknameUseCase(
      SignUpConfirmNicknameParams(
        availableNickname: availableNickname,
        currentNickname: currentNickname,
      ),
    );

    if (result.hasError) {
      _setErrorState(
        result.message,
        result.stackTrace ?? StackTrace.current,
      );
    } else {
      await _routerService.replace(
        SignUpPasswordRoute(
          signUpToken: signUpToken,
          nickname: currentNickname,
        ),
      );
    }
  }

  Future<void> completeFlow(
    GlobalKey<FormState> formKey, {
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final result = await _signUpCompleteUseCase(
      SignUpCompleteParams(
        signUpToken: signUpToken,
        nickname: nickname,
        password: password,
      ),
    );

    if (result.hasError) {
      _setErrorState(
        result.message,
        result.stackTrace ?? StackTrace.current,
      );
    } else {
      await _routerService.replace(
        const SignUpCompleteRoute(),
      );
    }
  }

  void pushToAgreePolicyScreen() {
    _routerService.push(const SignUpPolicyRoute());
  }

  void pushToLoginScreen() {
    _routerService.push(const LoginRoute());
  }
}
