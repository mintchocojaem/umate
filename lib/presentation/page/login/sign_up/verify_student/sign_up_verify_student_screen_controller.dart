import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';

final signUpVerifyStudentScreenControllerProvider =
    Provider.autoDispose<SignUpVerifyStudentScreenController>(
  (ref) => SignUpVerifyStudentScreenController(
    ref: ref,
  ),
);

class SignUpVerifyStudentScreenController {
  final Ref ref;

  SignUpVerifyStudentScreenController({
    required this.ref,
  });

  final TextEditingController _dkuStudentIdController = TextEditingController();
  final TextEditingController _dkuPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController get dkuStudentIdController => _dkuStudentIdController;

  TextEditingController get dkuPasswordController => _dkuPasswordController;

  GlobalKey<FormState> get formKey => _formKey;

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
    final bool result = await _pushSignUpAgreementPage();
    if (result) {
      _isAgreePolicy = true;
      ref.notifyListeners();
    }
  }

  Future<bool> _pushSignUpAgreementPage() async {
    final bool? success = await ref
        .read(routerProvider)
        .push(RouteInfo.signUpAgreement.fullPath)
        .then((value) => value as bool?);

    return success ?? false;
  }

  Color getAgreePolicyColor() {
    return _isAgreePolicy ? Colors.green : Colors.white30;
  }

  Future<bool> verifyStudent() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    return true;
  }
}
