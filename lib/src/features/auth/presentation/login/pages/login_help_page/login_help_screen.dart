import 'package:danvery/src/core/core.dart';
import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'login_help_screen_controller.dart';

class LoginHelpScreen extends ConsumerWidget with LoginHelpScreenController{
  const LoginHelpScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '로그인을 어떻게 도와드릴까요?',
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbListCardTile(
            leading: const Icon(Icons.login_rounded),
            titleText: '회원가입을 하고 싶어요',
            onTap: () {
              pushVerifyStudentPage(ref);
            },
            trailing: const Icon(Icons.chevron_right),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbListCardTile(
            leading: const Icon(Icons.person_rounded),
            titleText: '아이디(학번)을 잊어버렸어요',
            onTap: () {
            },
            trailing: const Icon(Icons.chevron_right),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbListCardTile(
            leading: const Icon(Icons.lock),
            titleText: '비밀번호를 잊어버렸어요',
            onTap: () {

            },
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}