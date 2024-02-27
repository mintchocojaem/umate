import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/router_service.dart';

final agreePrivacyPolicyViewModelProvider =
    NotifierProvider.autoDispose<AgreePrivacyPolicyViewModel, bool>(
  () => AgreePrivacyPolicyViewModel(),
);

class AgreePrivacyPolicyViewModel extends AutoDisposeNotifier<bool> {
  @override
  bool build() {
    // TODO: implement build
    return false;
  }

  Future<void> agreePrivacyPolicy({
    required bool maxScrollExtent,
    required ScrollController scrollController,
  }) async {
    if (maxScrollExtent) {
      state = true;
      ref.read(routerServiceProvider).pop();
    } else {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}
