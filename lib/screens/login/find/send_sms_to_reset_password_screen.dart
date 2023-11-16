import 'package:danvery/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';

class SendSMStoResetPasswordScreen extends ConsumerStatefulWidget{

  const SendSMStoResetPasswordScreen({super.key});

  @override
  createState() => _SendSMStoResetPasswordScreen();
}

class _SendSMStoResetPasswordScreen extends ConsumerState<SendSMStoResetPasswordScreen>{
  late final TextEditingController phoneNumberController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    phoneNumberController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    phoneNumberController.dispose();
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
              '가입하신 휴대폰\n번호로 본인인증이 필요해요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: phoneNumberController,
              labelText: '휴대폰 번호',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              readOnly: false,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '휴대폰 번호를 입력해주세요';
                }
                return null;
              },
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
              .sendSMStoResetPassword(phoneNumberController.text);
        },
        buttonText: '인증코드 전송하기',
      ),
    );
  }
}
