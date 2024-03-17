import 'package:auto_route/annotations.dart';
import 'package:danvery/src/core/utils/auth_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/snack_bar/snack_bar_service.dart';
import '../../../../design_system/orb/components/components.dart';
import '../providers/sign_up_provider.dart';

@RoutePage()
class SignUpVerifyCodeScreen extends ConsumerStatefulWidget {
  final String signUpToken;
  final String phoneNumber;

  const SignUpVerifyCodeScreen({
    super.key,
    required this.signUpToken,
    required this.phoneNumber,
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
    ref.listen(
      signUpProvider,
      (previous, next) {
        if (!next.isLoading && next.hasError) {
          ref.read(snackBarServiceProvider).show(
                context,
                type: OrbSnackBarType.error,
                message: next.message!,
              );
        }
      },
    );

    final submitButton = OrbButton(
      onPressed: () async {
        await ref.read(signUpProvider.notifier).verifyCodeFlow(
              formKey,
              signUpToken: widget.signUpToken,
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
                    await ref.read(signUpProvider.notifier).sendCode(
                      signUpToken: widget.signUpToken,
                      phoneNumber: widget.phoneNumber,
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
      submitButtonOnKeyboard: submitButton,
    );
  }
}
