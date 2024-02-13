import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/configs.dart';
import '../../../../features.dart';

mixin class AgreePolicyScreenController {
  void addMaxScrollExtentListener({
    required ScrollController scrollController,
    required Function(bool value) onChangeMaxScrollExtent,
  }) {
    bool maxScrollExtent = false;
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !maxScrollExtent) {
        maxScrollExtent = true;
        onChangeMaxScrollExtent(maxScrollExtent);
      } else if (scrollController.offset <
              scrollController.position.maxScrollExtent &&
          maxScrollExtent) {
        maxScrollExtent = false;
        onChangeMaxScrollExtent(maxScrollExtent);
      }
    });
  }

  Future<void> agreePolicy(
    WidgetRef ref, {
    required bool maxScrollExtent,
    required ScrollController scrollController,
  }) async {
    if (maxScrollExtent) {
      ref.read(agreePrivacyPolicyServiceProvider.notifier).agreePolicy();
      ref.read(appRouterProvider).pop();
    } else {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  String submitButtonText({required bool maxScrollExtent}) {
    if (maxScrollExtent) {
      return '모두 동의하기';
    } else {
      return '아래로 스크롤하기';
    }
  }
}
