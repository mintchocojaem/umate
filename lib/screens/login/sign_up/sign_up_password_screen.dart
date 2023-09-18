import 'package:danvery/domain/auth/sign_up/sign_up_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_up_nickname_screen.dart';

class SignUpPasswordScreen extends ConsumerWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignUpPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return OrbScaffold(
      pageHelpText: '단버리 로그인에\n사용할 비밀번호를 입력해주세요',
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrbTextFormField(
              controller: _passwordController,
              labelText: '비밀번호',
              textInputAction: TextInputAction.next,
              maxLength: 20,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: _passwordConfirmController,
              labelText: '비밀번호 확인',
              textInputAction: TextInputAction.done,
              maxLength: 20,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요';
                }
                if(value != _passwordController.text){
                  return '비밀번호가 일치하지 않습니다';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          if(!_formKey.currentState!.validate()){
            return;
          }
          if(_passwordController.text != _passwordConfirmController.text){
            return;
          }
          await ref.read(signUpProvider.notifier).signUp(
            ref.read(signUpProvider).value!.signUpToken,
            ref.read(signUpValidNicknameProvider)!,
            _passwordController.text,
          );
        },
        buttonText: '완료',
      ),
    );
  }
}
