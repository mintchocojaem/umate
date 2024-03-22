import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/router_service.dart';
import '../../../../../core/services/snack_bar/snack_bar_service.dart';
import '../../../../../core/utils/auth_validator.dart';
import '../../../../../design_system/orb/components/components.dart';
import '../../../auth_dependency_injections.dart';
import '../../providers/states/sign_up_verify_student_state.dart';

@RoutePage()
class SignUpVerifyStudentScreen extends ConsumerStatefulWidget {
  const SignUpVerifyStudentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpVerifyStudentScreenState();
  }
}

class _SignUpVerifyStudentScreenState
    extends ConsumerState<SignUpVerifyStudentScreen> with AuthValidator {
  final TextEditingController dkuStudentIdController = TextEditingController();
  final TextEditingController dkuPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ref.listen(
      signUpVerifyStudentProvider,
      (previous, next) {
        if (next is SignUpVerifyStudentFailure) {
          ref.read(snackBarServiceProvider).showException(
                context,
                next.exception,
              );
        } else if (next is SignUpVerifyStudentSuccess) {
          ref.read(routerServiceProvider).replace(const SignUpSendCodeRoute());
        }
      },
    );

    final submitButton = OrbButton(
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return;
        }

        await ref.read(signUpVerifyStudentProvider.notifier).verifyStudent(
              dkuStudentId: dkuStudentIdController.text,
              dkuPassword: dkuPasswordController.text,
              isAgreePolicy: ref.read(signUpPolicyProvider),
            );
      },
      buttonText: '학생 인증하기',
    );

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
                return validateStudentId(studentId: value);
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: dkuPasswordController,
              labelText: '비밀번호',
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return validatePassword(password: value);
              },
            ),
            const SizedBox(height: 32),
            OrbListCardTile(
              titleText: '개인정보 이용약관에 동의하기',
              leading: Icon(
                Icons.check_circle,
                color: ref.watch(signUpPolicyProvider)
                    ? Colors.green
                    : Colors.grey,
              ),
              onTap: () {
                ref
                    .read(routerServiceProvider)
                    .push(const SignUpAgreePolicyRoute());
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
