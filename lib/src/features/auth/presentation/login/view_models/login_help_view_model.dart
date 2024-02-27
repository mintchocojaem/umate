import 'dart:async';

import 'package:danvery/src/core/services/router/router_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginHelpViewModelProvider =
    NotifierProvider.autoDispose<LoginHelpViewModel, void>(
  () => LoginHelpViewModel(),
);

class LoginHelpViewModel extends AutoDisposeNotifier<void>{
  @override
  FutureOr<void> build() {
    return null;
  }

  void goToSignUp() {
    ref.read(routerServiceProvider).replace(const VerifyStudentRoute());
  }

}