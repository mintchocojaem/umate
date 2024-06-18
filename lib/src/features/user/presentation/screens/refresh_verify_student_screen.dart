import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';
import '../../../../core/utils/app_exception.dart';
import '../../../../core/utils/auth_validator.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/use_cases/refresh_verify_student.dart';
import '../providers/login_token_provider.dart';
import 'verify_student_screen.dart';

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

    return VerifyStudentScreen(
      dkuStudentIdController: dkuStudentIdController,
      dkuPasswordController: dkuPasswordController,
      isDismissible: false,
      onAgreePolicy: () async {
        final result = await AsyncValue.guard(
          () => ref.read(
            refreshVerifyStudentProvider(
              RefreshVerifyStudentParams(
                dkuStudentId: dkuStudentIdController.text,
                dkuPassword: dkuPasswordController.text,
              ),
            ),
          ),
        );

        result.when(
          data: (data) {
            ref.read(loginTokenProvider.notifier).logout();
            context.showSnackBar(
              message: '학생 인증이 갱신되었습니다. 다시 로그인해주세요.',
            );
          },
          loading: () {},
          error: (error, _) {
            if (error is! AppException) return;
            context.showErrorSnackBar(
              error: error,
            );
          },
        );
      },
    );
  }
}
