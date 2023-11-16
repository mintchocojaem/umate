import 'package:danvery/domain/auth/sign_up/sign_up_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpNicknameScreen extends ConsumerStatefulWidget{
  const SignUpNicknameScreen({Key? key}) : super(key: key);

  @override
  createState() => _SignUpNicknameScreen();
}


class _SignUpNicknameScreen extends ConsumerState<SignUpNicknameScreen> {
  late final TextEditingController nicknameController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    nicknameController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nicknameController.dispose();
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
              '단버리에서 사용할\n닉네임을 입력해주세요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OrbTextFormField(
                    controller: nicknameController,
                    labelText: '닉네임',
                    textInputAction: TextInputAction.next,
                    helperText: "",
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '닉네임을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                OrbButton(
                  buttonSize: OrbButtonSize.compact,
                  enabledBackgroundColor: themeData.colorScheme.secondary,
                  enabledForegroundColor: themeData.colorScheme.onSecondary,
                  borderRadius: 10,
                  onPressed: () async {
                    final signupNotifier = ref.read(signUpProvider.notifier);
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    await signupNotifier.verifyNickname(nicknameController.text);
                    if (signupNotifier.validNickname.isNotEmpty) {
                      if (!context.mounted) return;
                      await OrbDialog(
                        title: '닉네임 중복확인',
                        message: '선택한 닉네임을 사용할 수 있어요!',
                        rightButtonText: '닫기',
                        onLeftButtonPressed:  () async{},
                        onRightButtonPressed: () async{},
                      ).show(context);
                    }
                  },
                  buttonText: '중복확인',
                ),
              ],
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          if (!formKey.currentState!.validate()) {
            return;
          }
          await ref
              .read(signUpProvider.notifier)
              .setNickname(nicknameController.text);
        },
        buttonText: '다음',
      ),
    );
  }
}
