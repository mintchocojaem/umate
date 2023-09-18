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
    return OrbScaffold(
      pageHelpText: '문자로 받은\n인증번호 6자리를 입력해주세요',
      body: Form(
        key: _formKey,
        child: Column(
          children: [
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
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref.read(signUpProvider.notifier).verifySMS(
              ref.read(signUpProvider).value!.signUpToken,
              _smsCodeController.text);
        },
        buttonText: '다음',
      ),
    );
  }
}
