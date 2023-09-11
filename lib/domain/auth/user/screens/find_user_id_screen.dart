import 'package:danvery/domain/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modules/orb/components/components.dart';

class FindUserIdScreen extends ConsumerWidget{
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FindUserIdScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return OrbScaffold(
      pageHelpText: '가입하신 휴대폰\n번호로 아이디를 보내드릴게요',
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            OrbTextFormField(
              controller: _phoneNumberController,
              labelText: '휴대폰 번호',
              maxLength: 11,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
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
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref.read(userProvider.notifier).findUserId(_phoneNumberController.text);
        },
        child: const Text('확인'),
      ),
    );
  }

}
