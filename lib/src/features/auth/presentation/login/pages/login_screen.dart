import 'package:danvery/src/module/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_screen_mixin.dart';

class LoginScreen extends ConsumerWidget with LoginScreenMixin {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '로그인을 하기 위해\n학번과 비밀번호를 입력해주세요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: studentIdController,
              labelText: '학번',
              keyboardType: TextInputType.number,
              maxLength: 8,
              validator: (value) {
                return validateStudentId(studentId: value);
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: passwordController,
              labelText: '비밀번호',
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return validatePassword(password: value);
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                pushSignUpVerifyStudent(ref);
              },
              child: Text(
                '단버리에 처음 오셨나요?',
                style: themeData.textTheme.bodyMedium?.copyWith(
                  color: themeData.colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          await login(
            ref,
            formKey: formKey,
            studentIdController: studentIdController,
            passwordController: passwordController,
          );
        },
        buttonText: '로그인하기',
      ),
      submitHelper: TextButton(
        onPressed: () {
          //screenController.pushLoginHelpPage();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '로그인에 도움이 필요한가요?',
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: themeData.colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: themeData.colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
