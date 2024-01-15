import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../../../domain/domain.dart';
import '../../../../presentation.dart';

final signUpVerifyStudentScreenControllerProvider =
    Provider.autoDispose<_SignUpVerifyStudentScreenController>((ref) {
  ref.watch(signUpProvider.notifier);
  return _SignUpVerifyStudentScreenController(
    ref: ref,
  );
});

final class _SignUpVerifyStudentScreenController extends ScreenController {
  _SignUpVerifyStudentScreenController({
    required super.ref,
  });

  final TextEditingController _dkuStudentIdController = TextEditingController();

  TextEditingController get dkuStudentIdController => _dkuStudentIdController;

  final TextEditingController _dkuPasswordController = TextEditingController();

  TextEditingController get dkuPasswordController => _dkuPasswordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  final List<CancelToken> _cancelTokens = [];
  bool _isAgreePolicy = false;

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

  Future<void> agreePolicy() async {
    final bool result = await ref
            .read(routerProvider)
            .push(RouteInfo.signUpAgreement.fullPath)
            .then((value) => value as bool?) ??
        false;

    if (result) {
      _isAgreePolicy = true;
      ref.notifyListeners();
    }
  }

  Color getAgreePolicyColor() {
    return _isAgreePolicy ? Colors.green : Colors.white30;
  }

  Future<void> verifyStudent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_isAgreePolicy) {
      OrbSnackBar.show(
        message: '개인정보 이용약관에 동의가 필요해요',
        type: OrbSnackBarType.warning,
      );
      return;
    }

    final CancelToken cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    await ref.read(signUpProvider.notifier).verifyStudent(
          cancelToken,
          dkuStudentId: _dkuStudentIdController.text,
          dkuPassword: _dkuPasswordController.text,
        );

    if (ref.read(signUpProvider).hasValue) {
      ref.read(routerProvider).push(RouteInfo.signUpCheckInfo.fullPath);
    }
  }

  void _cancelAllRequest() {
    if (_cancelTokens.isNotEmpty) {
      for (var cancelToken in _cancelTokens) {
        cancelToken.cancel();
      }
    }
  }

  void popPage() {
    _cancelAllRequest();
    ref.read(routerProvider).pop();
  }

}
