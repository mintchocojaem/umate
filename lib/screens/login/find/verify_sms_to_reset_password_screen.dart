import 'package:danvery/domain/domain.dart';
import 'package:danvery/screens/login/find/send_sms_to_reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';
import '../../../routes/route_path.dart';
import '../../../routes/router_provider.dart';

class VerifySMStoResetPasswordScreen extends ConsumerWidget {
  final TextEditingController _verifySMSController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  VerifySMStoResetPasswordScreen({super.key});

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
              controller: _verifySMSController,
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
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          final resetPasswordToken = ref.read(resetPasswordTokenProvider);
          final AsyncValue<bool> result = await AsyncValue.guard(() async => await ref
              .read(authRepositoryProvider)
              .verifySMStoResetPassword(resetPasswordToken!, _verifySMSController.text));
          if(!result.hasError){
            ref.read(routerProvider).pushReplacement(RouteInfo.resetPassword.fullPath);
          }
        },
        buttonText: '확인',
      ),
    );
  }
}
