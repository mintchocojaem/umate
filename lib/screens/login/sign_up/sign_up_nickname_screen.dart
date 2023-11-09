import 'package:danvery/domain/auth/sign_up/sign_up_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpNicknameScreen extends ConsumerWidget {
  final TextEditingController nicknameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SignUpNicknameScreen({super.key});

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
              '단버리에서 사용할\n닉네임을 입력해주세요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: nicknameController,
              labelText: '닉네임',
              textInputAction: TextInputAction.next,
              maxLength: 20,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '닉네임을 입력해주세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            OrbButton(
              buttonSize: OrbButtonSize.compact,
              buttonTheme: OrbButtonTheme.onSurface,
              borderRadius: 10,
              onPressed: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                await ref
                    .read(signUpProvider.notifier)
                    .verifyNickname(nicknameController.text);
                if (ref.read(signUpProvider.notifier).validNickname.isNotEmpty) {
                  if (!context.mounted) return;
                  await showDialog(
                    context: context,
                    builder: (context) => const OrbDialog(
                      title: '닉네임 중복확인',
                      message: '선택한 닉네임을 사용할 수 있어요!',
                      rightButtonText: '닫기',
                    ),
                  );
                }
              },
              buttonText: '중복확인',
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
