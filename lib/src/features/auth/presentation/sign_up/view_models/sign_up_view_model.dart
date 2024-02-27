import 'dart:async';

import 'package:danvery/src/core/services/router/router_service.dart';
import 'package:danvery/src/features/auth/domain/use_cases/send_sms_code_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../design_system/orb/components/components.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/models/sign_up_info_model.dart';
import '../../../domain/use_cases/verify_student_use_case.dart';
import 'agree_privacy_policy_view_model.dart';

final signUpViewModelProvider =
    AsyncNotifierProvider.autoDispose<SignUpViewModel, SignUpInfoModel>(
  () => SignUpViewModel(),
);

class SignUpViewModel extends AutoDisposeAsyncNotifier<SignUpInfoModel> {
  KeepAliveLink? _link;

  late final VerifyStudentUseCase _verifyStudentUseCase;
  late final SendSmsCodeUseCase _sendSmsCodeUseCase;

  @override
  FutureOr<SignUpInfoModel> build() {
    // TODO: implement build
    final authRepository = ref.watch(authRepositoryImplProvider);
    _verifyStudentUseCase = VerifyStudentUseCase(
      authRepository: authRepository,
    );
    _sendSmsCodeUseCase = SendSmsCodeUseCase(
      authRepository: authRepository,
    );
    return future;
  }

  Future<void> verifyStudent(
    GlobalKey<FormState> formKey, {
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _link ??= ref.keepAlive();

    final agreePolicy = ref.read(agreePrivacyPolicyViewModelProvider);

    if (!agreePolicy) {
      OrbSnackBar.show(
        type: OrbSnackBarType.warning,
        message: '개인정보 이용약관에 동의가 필요해요',
      );
      return;
    }

    state = await _verifyStudentUseCase(
      params: VerifyStudentParams(
        dkuStudentId: dkuStudentId,
        dkuPassword: dkuPassword,
      ),
    );

    if (state.hasError) {
      _link?.close();
    }
  }

  Future<bool> sendSMS(
    String signUpToken, {
    required String phoneNumber,
  }) async {
    if (state.hasError || !state.hasValue) {
      return false;
    }

    final result = await _sendSmsCodeUseCase(
      params: SendSmsCodeParams(
        signUpToken: signUpToken,
        phoneNumber: phoneNumber,
      ),
    );

    return result.hasValue;
  }

  void goToAgreePolicy() {
    ref.read(routerServiceProvider).push(const AgreePolicyRoute());
  }
}
