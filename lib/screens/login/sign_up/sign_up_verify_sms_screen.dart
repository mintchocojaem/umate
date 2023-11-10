import 'package:danvery/domain/auth/sign_up/sign_up_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpVerifySmsScreen extends ConsumerWidget {
  final TextEditingController _smsCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignUpVerifySmsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: _formKey,
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
              controller: _smsCodeController,
              labelText: '인증번호(6자리 숫자)',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              maxLength: 6,
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
              buttonTheme: OrbButtonTheme.secondary,
              borderRadius: 10,
              onPressed: () async {
                await ref.read(signUpProvider.notifier).resendSMS();
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
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref
              .read(signUpProvider.notifier)
              .verifySMS(_smsCodeController.text);
        },
        buttonText: '다음',
      ),
    );
  }
}
