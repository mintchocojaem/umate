import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/route_error_screen.dart';
import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/services/snack_bar/snack_bar_service.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../../../design_system/orb/components/components.dart';
import '../../../auth_dependency_injections.dart';
import '../../providers/states/sign_up_send_code_state.dart';
import '../../providers/states/sign_up_verify_student_state.dart';

@RoutePage()
class SignUpSendCodeScreen extends ConsumerStatefulWidget {
  const SignUpSendCodeScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpSendCodeScreenState();
  }
}

class _SignUpSendCodeScreenState extends ConsumerState<SignUpSendCodeScreen>
    with AuthValidator {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    majorController.dispose();
    studentIdController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final signUpVerifyStudentState = ref.watch(signUpVerifyStudentProvider);

    if (signUpVerifyStudentState is! SignUpVerifyStudentSuccess) {
      return const RouteErrorScreen();
    }

    studentIdController.text =
        signUpVerifyStudentState.signUpInfo.student.studentId;
    majorController.text = signUpVerifyStudentState.signUpInfo.student.major;

    ref.listen(
      signUpSendCodeProvider,
      (prev, next) {
        if (next is SignUpSendCodeFailure) {
          ref.read(snackBarServiceProvider).showException(
                context,
                next.exception,
              );
        } else if (next is SignUpSendCodeSuccess) {
          ref
              .read(routerServiceProvider)
              .replace(const SignUpVerifyCodeRoute());
        }
      },
    );

    final submitButton = OrbButton(
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return;
        }

        await ref.read(signUpSendCodeProvider.notifier).sendCode(
              signUpToken: signUpVerifyStudentState.signUpInfo.signUpToken,
              phoneNumber: phoneNumberController.text,
            );
      },
      buttonText: '본인 인증하기',
    );

    final themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${signUpVerifyStudentState.signUpInfo.student.studentName}님 정보가 맞나요?',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: studentIdController,
              labelText: '학번',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: majorController,
              labelText: '학과',
              readOnly: true,
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: phoneNumberController,
              maxLength: 11,
              labelText: '휴대폰 번호',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              readOnly: false,
              autofocus: true,
              validator: (value) {
                return validatePhoneNumber(phoneNumber: value);
              },
            ),
          ],
        ),
      ),
      submitButton: submitButton,
      submitButtonOnKeyboard: submitButton.copyWith(
        buttonRadius: OrbButtonRadius.none,
      ),
      /*
      submitHelper: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '내정보가 일치하지 않나요?',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
       */
    );
  }
}
