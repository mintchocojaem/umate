import 'package:danvery/domain/domain.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../routes/route_path.dart';

class SignUpVerifyStudentScreen extends ConsumerStatefulWidget {
  const SignUpVerifyStudentScreen({super.key});

  @override
  createState() => _SignUpVerifyStudentScreen();
}

class _SignUpVerifyStudentScreen extends ConsumerState<SignUpVerifyStudentScreen> {
  late final TextEditingController dkuStudentIdController;
  late final TextEditingController dkuPasswordController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    dkuPasswordController = TextEditingController();
    dkuStudentIdController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dkuPasswordController.dispose();
    dkuStudentIdController.dispose();
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
                if (value == null || value.isEmpty) {
                  return '학번을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: dkuPasswordController,
              labelText: '비밀번호',
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            OrbListCardTile(
              titleText: '개인정보 이용약관에 동의하기',
              leading: Icon(
                Icons.check,
                color: ref.watch(isAgreePrivacyPolicyProvider) &&
                        ref.watch(isAgreeThirdPartyProvider)
                    ? Colors.green
                    : themeData.colorScheme.onSurface,
              ),
              onTap: () {
                ref.read(routerProvider).push(RouteInfo.signUpAgree.fullPath);
              },
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          if (!formKey.currentState!.validate()) {
            return;
          }

          await ref.read(signUpProvider.notifier).verifyStudent(
              dkuStudentIdController.text, dkuPasswordController.text);
        },
        buttonText: '학생 인증하기',
      ),
    );
  }
}
