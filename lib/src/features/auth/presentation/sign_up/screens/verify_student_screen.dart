import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../design_system/orb/components/components.dart';
import '../view_models/agree_privacy_policy_view_model.dart';
import '../view_models/sign_up_view_model.dart';

@RoutePage()
class VerifyStudentScreen extends ConsumerStatefulWidget {
  const VerifyStudentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VerifyStudentScreenState();
  }
}

class _VerifyStudentScreenState extends ConsumerState<VerifyStudentScreen> {
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

  Color agreePolicyIconColor({required bool agreePolicy}) {
    if (agreePolicy) {
      return Colors.green;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final submitButton = OrbButton(
      onPressed: () async {
        await ref.read(signUpViewModelProvider.notifier).verifyStudent(
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
                return value;
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: dkuPasswordController,
              labelText: '비밀번호',
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return value;
              },
            ),
            const SizedBox(height: 32),
            OrbListCardTile(
              titleText: '개인정보 이용약관에 동의하기',
              leading: Consumer(
                builder: (context, ref, child) {
                  final agreePrivacyPolicy = ref.watch(
                    agreePrivacyPolicyViewModelProvider,
                  );
                  return Icon(
                    Icons.check_circle,
                    color: agreePolicyIconColor(
                      agreePolicy: agreePrivacyPolicy,
                    ),
                  );
                },
              ),
              onTap: () {
                ref.read(signUpViewModelProvider.notifier).goToAgreePolicy();
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
