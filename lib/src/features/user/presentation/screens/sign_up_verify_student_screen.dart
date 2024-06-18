import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/auth_validator.dart';
import '../../../../design_system/orb/orb.dart';
import '../providers/sign_up_info_provider.dart';
import 'verify_student_screen.dart';

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
      signUpInfoProvider,
      (_, next) {
        if (!next.isLoading && next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showErrorSnackBar(
            error: error,
          );
        } else if (next.value != null) {
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
        await ref.read(signUpInfoProvider.notifier).verifyStudent(
              dkuStudentId: dkuStudentIdController.text,
              dkuPassword: dkuPasswordController.text,
            );
      },
    );
  }
}
