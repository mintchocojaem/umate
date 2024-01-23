import 'package:danvery/src/features/auth/presentation/presentation.dart';
import 'package:danvery/src/module/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyStudentScreen extends ConsumerWidget
    with VerifyStudentScreenMixin {
  VerifyStudentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: formKey,
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
              controller: dkuStudentIdController,
              labelText: '학번',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLength: 8,
              validator: (value) {
                return checkStudentId(studentId: value);
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: dkuPasswordController,
              labelText: '비밀번호',
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return checkPassword(password: value);
              },
            ),
            const SizedBox(height: 32),
            Consumer(
              builder: (context, ref, child) {
                return OrbListCardTile(
                  titleText: '개인정보 이용약관에 동의하기',
                  leading: Icon(
                    Icons.check,
                    color: getAgreePrivacyPolicyColor(ref),
                  ),
                  onTap: () {
                    agreePrivacyPolicy(ref);
                  },
                );
              },
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          await verifyStudent(
            ref,
            formKey: formKey,
            dkuStudentIdController: dkuStudentIdController,
            dkuPasswordController: dkuPasswordController,
          );
        },
        buttonText: '학생 인증하기',
      ),
    );
  }
}
