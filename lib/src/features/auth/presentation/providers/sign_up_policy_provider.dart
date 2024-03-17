import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';

final signUpPrivacyProvider =
    NotifierProvider.autoDispose<SingUpPolicyNotifier, bool>(
  () => SingUpPolicyNotifier(),
);

class SingUpPolicyNotifier extends AutoDisposeNotifier<bool> {
  late final RouterService _routerService;

  @override
  bool build() {
    // TODO: implement build
    _routerService = ref.read(routerServiceProvider);
    return false;
  }

  Future<void> agreePrivacyPolicy({
    required bool maxScrollExtent,
    required ScrollController scrollController,
  }) async {
    if (maxScrollExtent) {
      state = true;
      _routerService.pop();
    } else {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}
