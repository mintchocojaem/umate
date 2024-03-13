import 'dart:async';

import 'package:danvery/src/core/services/router/router_service.dart';
import 'package:danvery/src/core/utils/state.dart';
import 'package:danvery/src/features/auth/domain/use_cases/send_sign_up_code_use_case.dart';
import 'package:danvery/src/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:danvery/src/features/auth/domain/use_cases/verify_nickname_use_case.dart';
import 'package:danvery/src/features/auth/domain/use_cases/verify_sign_up_code_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../domain/models/sign_up_info_model.dart';
import '../../../domain/use_cases/verify_student_use_case.dart';

final signUpProvider =
    NotifierProvider.autoDispose<SignUpNotifier, AsyncState<SignUpInfoModel>>(
  () => SignUpNotifier(),
);

class SignUpNotifier extends AutoDisposeNotifier<AsyncState<SignUpInfoModel>> {
  late final VerifyStudentUseCase _verifyStudentUseCase;
  late final SendSignUpCodeUseCase _sendSignUpCodeCodeUseCase;
  late final VerifySignUpCodeUseCase _verifySignUpCodeUseCase;
  late final VerifyNicknameUseCase _verifyNicknameUseCase;
  late final SignUpUseCase _signUpUseCase;

  late final RouterService _routerService;

  @override
  AsyncState<SignUpInfoModel> build() {
    // TODO: implement build
    _routerService = ref.watch(routerServiceProvider);

    final authRepository = ref.watch(authRepositoryImplProvider);
    _verifyStudentUseCase = VerifyStudentUseCase(
      authRepository: authRepository,
    );
    _sendSignUpCodeCodeUseCase = SendSignUpCodeUseCase(
      authRepository: authRepository,
    );
    _verifySignUpCodeUseCase = VerifySignUpCodeUseCase(
      authRepository: authRepository,
    );
    _verifyNicknameUseCase = VerifyNicknameUseCase(
      authRepository: authRepository,
    );
    _signUpUseCase = SignUpUseCase(
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

  Future<void> verifyStudent(
    GlobalKey<FormState> formKey, {
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    state = AsyncState.loading();

    state = await AsyncState.guard(
      () => _verifyStudentUseCase(
        params: VerifyStudentParams(
          dkuStudentId: dkuStudentId,
          dkuPassword: dkuPassword,
        ),
      ),
    );

    if (state.hasData) {
      await _routerService.replace(
        SendSignUpCodeRoute(
          signUpToken: state.data!.signUpToken,
          student: state.data!.student,
        ),
      );
    }
  }

  Future<void> sendSignUpCode(
    GlobalKey<FormState> formKey, {
    required String signUpToken,
    required String phoneNumber,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final result = await AsyncState.guard(
      () => _sendSignUpCodeCodeUseCase(
        params: SendSignUpCodeParams(
          signUpToken: signUpToken,
          phoneNumber: phoneNumber,
        ),
      ),
    );

    if (result.hasError) {
      _setErrorState(
        result.message,
        result.stackTrace ?? StackTrace.current,
      );
    } else {
      await _routerService.replace(
        VerifySignUpCodeRoute(
          signUpToken: signUpToken,
          phoneNumber: phoneNumber,
        ),
      );
    }
  }

  Future<void> resendSignUpCode({
    required String signUpToken,
    required String phoneNumber,
  }) async {
    final result = await AsyncState.guard(
      () => _sendSignUpCodeCodeUseCase(
        params: SendSignUpCodeParams(
          signUpToken: signUpToken,
          phoneNumber: phoneNumber,
        ),
      ),
    );

    if (result.hasError) {
      _setErrorState(
        result.message,
        result.stackTrace ?? StackTrace.current,
      );
    }
  }

  Future<void> verifySignUpCode(
    GlobalKey<FormState> formKey, {
    required String signUpToken,
    required String code,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final result = await AsyncState.guard(
      () => _verifySignUpCodeUseCase(
        params: VerifySignUpCodeParams(
          signUpToken: signUpToken,
          code: code,
        ),
      ),
    );

    if (result.hasError) {
      _setErrorState(
        result.message,
        result.stackTrace ?? StackTrace.current,
      );
    } else {
      await _routerService.replace(
        VerifyNicknameRoute(signUpToken: signUpToken),
      );
    }
  }

  Future<bool> checkNickname(
    GlobalKey<FormState> formKey, {
    required String nickname,
  }) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    final result = await AsyncState.guard(
      () => _verifyNicknameUseCase(
        params: VerifyNicknameParams(
          nickname: nickname,
        ),
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

  Future<void> verifyNickname(
    GlobalKey<FormState> formKey, {
    required String signUpToken,
    required String availableNickname,
    required String currentNickname,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (availableNickname != currentNickname) {
      _setErrorState(
        '닉네임 중복을 확인해주세요',
        StackTrace.current,
      );
      return;
    }

    final result = await checkNickname(formKey, nickname: currentNickname);

    if (result) {
      await _routerService.replace(
        InputUserPasswordRoute(
          signUpToken: signUpToken,
          nickname: currentNickname,
        ),
      );
    }
  }

  Future<void> signUp(
    GlobalKey<FormState> formKey, {
    required String signUpToken,
    required String nickname,
    required String password,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final result = await AsyncState.guard(
      () => _signUpUseCase(
        params: SignUpParams(
          signUpToken: signUpToken,
          nickname: nickname,
          password: password,
        ),
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
    _routerService.push(const AgreePolicyRoute());
  }

  void pushToLoginScreen() {
    _routerService.push(const LoginRoute());
  }
}
