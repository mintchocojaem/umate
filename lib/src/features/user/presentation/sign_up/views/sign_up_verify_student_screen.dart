import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/utils/app_exception.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../verify_student/widgets/verify_student_screen.dart';
import '../providers/sign_up_provider.dart';

class SignUpVerifyStudentScreen extends ConsumerStatefulWidget {
  const SignUpVerifyStudentScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpVerifyStudentScreenState();
  }
}

class _SignUpVerifyStudentScreenState
    extends ConsumerState<SignUpVerifyStudentScreen> with AuthValidator {
  final TextEditingController dkuStudentIdController = TextEditingController();
  final TextEditingController dkuPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    dkuStudentIdController.dispose();
    dkuPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ref.listen(
      signUpNotifierProvider,
      (_, next) {
        if (next.isLoading) {
          return;
        } else if (next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showErrorSnackBar(
            error: error,
          );
        } else if (next.hasValue) {
          ref
              .read(routerServiceProvider)
              .pushReplacementNamed(AppRoute.signUp.name);
        }
      },
    );

    return VerifyStudentScreen(
      dkuStudentIdController: dkuStudentIdController,
      dkuPasswordController: dkuPasswordController,
      onAgreePolicy: () async {
        await ref.read(signUpNotifierProvider.notifier).verifyNewStudent(
              dkuStudentId: dkuStudentIdController.text,
              dkuPassword: dkuPasswordController.text,
            );
      },
      onTapCollectUserInfo: () {
        ref
            .read(routerServiceProvider)
            .pushReplacementNamed(AppRoute.signUpAgreePolicy.name);
      },
      onTapThirdParty: () {
        ref
            .read(routerServiceProvider)
            .pushNamed(AppRoute.signUpAgreePolicy.name);
      },
    );
  }
}
