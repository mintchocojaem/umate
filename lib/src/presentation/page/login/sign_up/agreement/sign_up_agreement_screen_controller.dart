import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../../presentation.dart';

final signUpAgreementScreenControllerProvider =
    Provider.autoDispose<_SignUpAgreementScreenController>((ref) {
  return _SignUpAgreementScreenController(
    ref: ref,
  );
});

final class _SignUpAgreementScreenController  extends ScreenController {

  _SignUpAgreementScreenController({
    required super.ref,
  });

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  bool _isAgreePersonalInfo = false;
  bool _isAgreeThirdParty = false;
  bool _maxScrollExtent = false;

  @override
  void init() {
    //Todo: implement init
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
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      ref.notifyListeners();
    }
  }

  String agreeButtonText() {
    return _maxScrollExtent ? '모두 동의하기' : '아래로 스크롤하기';
  }

  void popPage() {
    ref.read(routerProvider).pop();
  }

}
