import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/route_path.dart';
import '../../routes/router_provider.dart';

class LoginHelpScreen extends ConsumerWidget {
  const LoginHelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
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
            titleText: '회원가입을 하고 싶어요',
            onTap: () {
              ref
                  .read(routerProvider)
                  .pushReplacement(RouteInfo.signUpVerifyStudent.fullPath);
            },
            trailing: const Icon(Icons.chevron_right),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbListCardTile(
            titleText: '아이디(학번)을 잊어버렸어요',
            onTap: () {
              ref.read(routerProvider).pushReplacement(RouteInfo.findUserId.fullPath);
            },
            trailing: const Icon(Icons.chevron_right),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbListCardTile(
            titleText: '비밀번호를 잊어버렸어요',
            onTap: () {
              ref
                  .read(routerProvider)
                  .pushReplacement(RouteInfo.sendSMStoResetPassword.fullPath);
            },
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
