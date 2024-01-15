import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../../../domain/domain.dart';
import '../../../../presentation.dart';

final signUpCheckInfoScreenControllerProvider =
    Provider.autoDispose<SignUpCheckInfoScreenController>(
  (ref) => SignUpCheckInfoScreenController(
    ref: ref,
  ),
);

final class SignUpCheckInfoScreenController extends ScreenController {

  SignUpCheckInfoScreenController({
    required super.ref,
  });

  final TextEditingController _studentIdController = TextEditingController();
  TextEditingController get studentIdController => _studentIdController;

  final TextEditingController _majorController = TextEditingController();
  TextEditingController get majorController => _majorController;

  final TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController get phoneNumberController => _phoneNumberController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final List<CancelToken> _cancelTokens = [];

  String getStudentName() {
    final student = ref.read(signUpProvider).requireValue.student;
    return student.studentName;
  }

  Future<void> sendSMS() async {

    if(!_formKey.currentState!.validate()){
      return;
    }

    if (!ref.read(signUpProvider).hasValue) {
      OrbSnackBar.show(
        message: '단국대학교 학생 인증이 먼저 필요해요',
        type: OrbSnackBarType.error,
      );
      return;
    }

    final CancelToken cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    final String phoneNumber = _phoneNumberController.text;
    await ref.read(signUpProvider.notifier).sendSMS(
      cancelToken,
      phoneNumber: phoneNumber,
    );
  }

  void _cancelAllRequests() {
    for (final cancelToken in _cancelTokens) {
      cancelToken.cancel();
    }
  }

  void popPage() {
    _cancelAllRequests();
    ref.read(routerProvider).pop();
  }


}