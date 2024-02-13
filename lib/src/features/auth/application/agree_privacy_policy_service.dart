import 'package:flutter_riverpod/flutter_riverpod.dart';

final agreePrivacyPolicyServiceProvider =
    NotifierProvider.autoDispose<AgreePrivacyPolicyNotifier, bool>(() {
  return AgreePrivacyPolicyNotifier();
});

class AgreePrivacyPolicyNotifier extends AutoDisposeNotifier<bool> {
  @override
  bool build() {
    // TODO: implement build
    return false;
  }

  Future<void> agreePolicy() async {
    state = true;
  }
}
