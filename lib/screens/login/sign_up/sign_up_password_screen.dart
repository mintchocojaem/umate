import 'package:danvery/domain/auth/sign_up/sign_up_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPasswordScreen extends ConsumerStatefulWidget {
  const SignUpPasswordScreen({super.key});

  @override
  createState() => _SignUpPasswordScreen();
}

class _SignUpPasswordScreen extends ConsumerState<SignUpPasswordScreen> {
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    passwordController.dispose();
    passwordConfirmController.dispose();
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
              '단버리 로그인에\n사용할 비밀번호를 입력해주세요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: passwordController,
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
              controller: passwordConfirmController,
              labelText: '비밀번호 확인',
              textInputAction: TextInputAction.done,
              maxLength: 20,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요';
                }
                if(value != passwordController.text){
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
          if(!formKey.currentState!.validate()){
            return;
          }
          if(passwordController.text != passwordConfirmController.text){
            return;
          }
          await ref.read(signUpProvider.notifier).signUp(
            passwordController.text,
          );
        },
        buttonText: '완료',
      ),
    );
  }
}
