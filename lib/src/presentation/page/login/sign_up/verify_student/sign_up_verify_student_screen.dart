import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../../presentation.dart';

class SignUpVerifyStudentScreen extends ConsumerWidget {
  const SignUpVerifyStudentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    final screenController =
        ref.watch(signUpVerifyStudentScreenControllerProvider);

    final ThemeData themeData = Theme.of(context);

    return OrbScaffold(
      orbAppBar: OrbAppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            screenController.popPage();
          },
        ),
      ),
      body: Form(
        key: screenController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '단국대학교 포털\n학생인증이 필요해요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: screenController.dkuStudentIdController,
              labelText: '학번',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLength: 8,
              validator: (value) {
                return screenController.checkStudentId(value);
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: screenController.dkuPasswordController,
              labelText: '비밀번호',
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return screenController.checkPassword(value);
              },
            ),
            const SizedBox(height: 32),
            OrbListCardTile(
              titleText: '개인정보 이용약관에 동의하기',
              leading: Icon(
                Icons.check,
                color: screenController.getAgreePolicyColor(),
              ),
              onTap: () async {
                await screenController.agreePolicy();
              },
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          await screenController.verifyStudent();
        },
        buttonText: '학생 인증하기',
      ),
    );
  }
}
