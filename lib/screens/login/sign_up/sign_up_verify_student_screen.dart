import 'package:danvery/domain/auth/auth.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../../../routes/route_name.dart';

final isAgreePrivacyPolicyProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final isAgreeThirdPartyProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final isAgreeAllProvider = StateProvider.autoDispose<bool>((ref) =>
    (ref.watch(isAgreePrivacyPolicyProvider) &&
        ref.watch(isAgreeThirdPartyProvider)) ||
    (ref.watch(isAgreeThirdPartyProvider) &&
        ref.watch(isAgreePrivacyPolicyProvider)));

class SignUpVerifyStudentScreen extends ConsumerStatefulWidget {
  const SignUpVerifyStudentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpVerifyStudentScreen();
  }
}

class _SignUpVerifyStudentScreen
    extends ConsumerState<SignUpVerifyStudentScreen> {
  late final TextEditingController _dkuStudentIdController;
  late final TextEditingController _dkuPasswordController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    // TODO: implement initState
    _dkuPasswordController = TextEditingController();
    _dkuStudentIdController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: _formKey,
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
              controller: _dkuStudentIdController,
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
              controller: _dkuPasswordController,
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
                  Icons.check_circle_rounded,
                  color: ref.watch(isAgreeAllProvider)
                      ? Colors.green
                      : themeData.colorScheme.onPrimary.withOpacity(0.5),
                ),
                onTap: () {
                  ref.read(routerProvider).push(RouteName.signUpAgree);
                }),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }

          await ref.read(signUpProvider.notifier).verifyStudent(
              _dkuStudentIdController.text, _dkuPasswordController.text);
        },
        buttonText: '학생 인증하기',
      ),
    );
  }
}
