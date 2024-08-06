import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';
import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/utils/app_exception.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../login/providers/login_token_provider.dart';
import '../providers/refresh_verify_student_provider.dart';
import '../widgets/verify_student_screen.dart';

class RefreshVerifyStudentScreen extends ConsumerStatefulWidget {
  const RefreshVerifyStudentScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RefreshVerifyStudentScreenState();
  }
}

class _RefreshVerifyStudentScreenState
    extends ConsumerState<RefreshVerifyStudentScreen> with AuthValidator {
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
      refreshVerifyStudentNotifierProvider,
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
          ref.read(loginTokenNotifierProvider.notifier).logout();
          context.showSnackBar(
            message: '학생 인증이 갱신되었습니다. 다시 로그인해주세요.',
          );
        }
      },
    );

    return VerifyStudentScreen(
      dkuStudentIdController: dkuStudentIdController,
      dkuPasswordController: dkuPasswordController,
      isDismissible: false,
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
      onAgreePolicy: () async {
        await ref.read(refreshVerifyStudentNotifierProvider.notifier).refresh(
              dkuStudentId: dkuStudentIdController.text,
              dkuPassword: dkuPasswordController.text,
            );
      },
    );
  }
}
