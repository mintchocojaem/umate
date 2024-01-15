import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../presentation.dart';

final loginHelpScreenControllerProvider =
    Provider.autoDispose<LoginHelpScreenController>(
  (ref) => LoginHelpScreenController(
    ref: ref,
  ),
);

final class LoginHelpScreenController extends ScreenController {
  LoginHelpScreenController({
    required super.ref,
  });

  void pushSignUpVerifyStudent() {
    ref
        .read(routerProvider)
        .pushReplacement(RouteInfo.signUpVerifyStudent.fullPath);
  }

  void popPage() {
    ref.read(routerProvider).pop();
  }

}
