import 'package:danvery/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpAgreementScreenController =
    Provider.autoDispose<SignUpAgreementScreenController>(
  (ref) => SignUpAgreementScreenController(
    ref: ref,
  ),
);

class SignUpAgreementScreenController {
  final Ref ref;

  SignUpAgreementScreenController({
    required this.ref,
  }) {
    _initScrollController();
  }

  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  bool _isAgreePersonalInfo = false;
  bool _isAgreeThirdParty = false;
  bool _maxScrollExtent = false;

  void _initScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        _maxScrollExtent = true;
        ref.notifyListeners();
      } else {
        _maxScrollExtent = false;
        ref.notifyListeners();
      }
    });
  }

  Future<void> agreeAll() async {
    if (_maxScrollExtent) {
      if (!_isAgreePersonalInfo && _isAgreeThirdParty) {
      } else {
        _isAgreePersonalInfo = true;
        _isAgreeThirdParty = true;
        ref.notifyListeners();
        ref.read(routerProvider).pop(true);
      }
    } else {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      ref.notifyListeners();
    }
  }

  String agreeButtonText() {
    return _maxScrollExtent ? '모두 동의하기' : '아래로 스크롤하기';
  }
}
