import 'package:auto_route/annotations.dart';
import 'package:danvery/src/core/utils/auth_validator.dart';
import 'package:danvery/src/features/auth/presentation/sign_up/providers/sign_up_policy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/snack_bar/snack_bar_service.dart';
import '../../../../../design_system/orb/components/components.dart';
import '../providers/sign_up_provider.dart';

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
  late final TextEditingController dkuStudentIdController;
  late final TextEditingController dkuPasswordController;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dkuStudentIdController = TextEditingController();
    dkuPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ref.listen(signUpProvider, (previous, next) {
      if (!next.isLoading && next.hasError) {
        ref.read(snackBarServiceProvider).show(
              context,
              type: OrbSnackBarType.error,
              message: next.message!,
            );
      }
    });

    final submitButton = OrbButton(
      onPressed: () async {
        if (!ref.read(signUpPrivacyProvider)) {
          ref.read(snackBarServiceProvider).show(
                context,
                type: OrbSnackBarType.warning,
                message: '개인정보 이용약관에 동의가 필요해요',
              );
          return;
        }
        await ref.read(signUpProvider.notifier).verifyStudentFlow(
              formKey,
              dkuStudentId: dkuStudentIdController.text,
              dkuPassword: dkuPasswordController.text,
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
                color: ref.watch(signUpPrivacyProvider)
                    ? Colors.green
                    : Colors.grey,
              ),
              onTap: () {
                ref.read(signUpProvider.notifier).pushToAgreePolicyScreen();
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
