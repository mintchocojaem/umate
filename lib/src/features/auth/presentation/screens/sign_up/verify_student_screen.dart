import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';
import '../../../../../modules/modules.dart';

@RoutePage()
class VerifyStudentScreen extends ConsumerWidget {
  const VerifyStudentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final TextEditingController dkuStudentIdController =
        TextEditingController();
    final TextEditingController dkuPasswordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ThemeData themeData = Theme.of(context);

    final OrbButton submitButton = OrbButton(
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return;
        }

        final bool agreePolicy = ref.read(agreePrivacyPolicyProvider);

        if (!agreePolicy) {
          OrbSnackBar.show(
            type: OrbSnackBarType.warning,
            message: '개인정보 이용약관에 동의가 필요해요',
          );
          return;
        }

        await ref.read(signUpProvider.notifier).verifyStudent(
              dkuStudentId: dkuStudentIdController.text,
              dkuPassword: dkuPasswordController.text,
            );
      },
      buttonText: '학생 인증하기',
    );

    Color agreePolicyIconColor({required bool agreePolicy}) {
      if (agreePolicy) {
        return Colors.green;
      }
      return Colors.grey;
    }

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
                return AuthValidator.validateStudentId(studentId: value);
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: dkuPasswordController,
              labelText: '비밀번호',
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return AuthValidator.validatePassword(password: value);
              },
            ),
            const SizedBox(height: 32),
            OrbListCardTile(
              titleText: '개인정보 이용약관에 동의하기',
              leading: Consumer(
                builder: (context, ref, child) {
                  final agreePolicy = ref.watch(
                    agreePrivacyPolicyProvider,
                  );
                  return Icon(
                    Icons.check_circle,
                    color: agreePolicyIconColor(
                      agreePolicy: agreePolicy,
                    ),
                  );
                },
              ),
              onTap: () {
                ref.read(appRouterProvider).push(const AgreePolicyRoute());
              },
            ),
          ],
        ),
      ),
      submitButton: submitButton,
      submitButtonOnKeyboard: submitButton.copyWith(
        buttonRadius: OrbButtonRadius.none,
      ),
    );
  }
}
