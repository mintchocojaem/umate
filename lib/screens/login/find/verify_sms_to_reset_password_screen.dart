import 'package:danvery/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';

class VerifySMStoResetPasswordScreen extends ConsumerStatefulWidget{
  const VerifySMStoResetPasswordScreen({super.key});

  @override
  createState() => _VerifySMStoResetPasswordScreen();
}

class _VerifySMStoResetPasswordScreen extends ConsumerState<VerifySMStoResetPasswordScreen> {

  late final TextEditingController verifySMSController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    verifySMSController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    verifySMSController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            OrbTextFormField(
              controller: verifySMSController,
              labelText: '인증번호(6자리 숫자)',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              maxLength: 6,
              readOnly: false,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '인증번호를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            OrbButton(
              showCoolDownTime: true,
              buttonCoolDown: const Duration(seconds: 30),
              buttonSize: OrbButtonSize.compact,
              enabledBackgroundColor: themeData.colorScheme.surfaceVariant,
              enabledForegroundColor: themeData.colorScheme.onSurface,
              borderRadius: 10,
              onPressed: () async {
                await ref.read(findProvider).resendSMStoResetPassword();
              },
              buttonText: '문자 다시 받기',
              buttonTextStyle: themeData.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          if (!formKey.currentState!.validate()) {
            return;
          }
          await ref
              .read(findProvider)
              .verifySMStoResetPassword(verifySMSController.text);
        },
        buttonText: '확인',
      ),
    );
  }
}
