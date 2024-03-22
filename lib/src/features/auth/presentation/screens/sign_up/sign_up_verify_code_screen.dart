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
import '../../providers/states/sign_up_verify_code_state.dart';
import '../../providers/states/sign_up_verify_student_state.dart';

@RoutePage()
class SignUpVerifyCodeScreen extends ConsumerStatefulWidget {
  const SignUpVerifyCodeScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpVerifyCodeScreenState();
  }
}

class _SignUpVerifyCodeScreenState extends ConsumerState<SignUpVerifyCodeScreen>
    with AuthValidator {
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpVerifyStudentState = ref.watch(signUpVerifyStudentProvider);
    final signUpSendCodeState = ref.watch(signUpSendCodeProvider);

    if (signUpVerifyStudentState is! SignUpVerifyStudentSuccess ||
        signUpSendCodeState is! SignUpSendCodeSuccess) {
      return const RouteErrorScreen();
    }

    ref.listen(
      signUpVerifyCodeProvider,
          (previous, next) {
        if (next is SignUpVerifyCodeFailure) {
          ref.read(snackBarServiceProvider).showException(
            context,
            next.exception,
          );
        } else if (next is SignUpVerifyCodeSuccess) {
          ref.read(routerServiceProvider).replace(const SignUpNicknameRoute());
        }
      },
    );

    ref.listen(
      signUpSendCodeProvider,
          (previous, next) {
        if (next is SignUpSendCodeSuccess) {
          ref.read(snackBarServiceProvider).show(
            context,
            type: OrbSnackBarType.info,
            message: '인증번호가 재전송되었어요.',
          );
        }
      },
    );

    final submitButton = OrbButton(
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return;
        }
        await ref.read(signUpVerifyCodeProvider.notifier).verifyCode(
              signUpToken: signUpVerifyStudentState.signUpInfo.signUpToken,
              code: codeController.text,
            );
      },
      buttonText: '다음',
    );

    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '문자로 받은\n인증번호 6자리를 입력해주세요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OrbTextFormField(
                    controller: codeController,
                    labelText: '인증번호(6자리 숫자)',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (value) {
                      return validateCode(code: value);
                    },
                    helperText: '',
                  ),
                ),
                const SizedBox(width: 8),
                OrbButton(
                  showCoolDownTime: true,
                  buttonCoolDown: const Duration(seconds: 30),
                  buttonSize: OrbButtonSize.compact,
                  buttonRadius: OrbButtonRadius.small,
                  enabledBackgroundColor: themeData.colorScheme.surfaceVariant,
                  enabledForegroundColor: themeData.colorScheme.onSurface,
                  onPressed: () async {
                    await ref.read(signUpSendCodeProvider.notifier).sendCode(
                          signUpToken:
                              signUpVerifyStudentState.signUpInfo.signUpToken,
                          phoneNumber: signUpSendCodeState.phoneNumber,
                        );
                  },
                  buttonText: '재전송',
                  buttonTextStyle: themeData.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      submitButton: submitButton,
      submitButtonOnKeyboard: submitButton.copyWith(
        buttonRadius: OrbButtonRadius.none,
      ),
    );
  }
}
