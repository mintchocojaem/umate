import 'package:danvery/src/config/config.dart';
import 'package:danvery/src/modules/modules.dart';
import 'package:danvery/src/features/auth/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'verify_student_screen_state.dart';

part 'verify_student_screen_event.dart';

class VerifyStudentScreen extends ConsumerWidget
    with VerifyStudentScreenState, VerifyStudentScreenEvent {
  const VerifyStudentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final TextEditingController dkuStudentIdController =
        TextEditingController();
    final TextEditingController dkuPasswordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final ThemeData themeData = Theme.of(context);

    final submitButton = OrbButton(
      onPressed: () async {
        await verifyStudent(
          ref,
          formKey: formKey,
          dkuStudentIdController: dkuStudentIdController,
          dkuPasswordController: dkuPasswordController,
        );
      },
      buttonText: '학생 인증하기',
    );

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
            OrbListCardTile(
              titleText: '개인정보 이용약관에 동의하기',
              leading: Consumer(
                builder: (context, ref, child) {
                  return Icon(
                    Icons.check_circle,
                    color: getAgreedPolicyColor(
                      agreePolicy: isAgreedPolicy(ref),
                    ),
                  );
                },
              ),
              onTap: () {
                agreePolicy(ref);
              },
            ),
          ],
        ),
      ),
      submitButton: submitButton,
      submitButtonAboveKeyboard: submitButton.copyWith(
        buttonSize: OrbButtonSize.wide,
        buttonRadius: OrbButtonRadius.none,
      ),
    );
  }
}
