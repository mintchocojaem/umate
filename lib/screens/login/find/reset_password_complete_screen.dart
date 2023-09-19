import 'package:danvery/routes/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modules/orb/components/components.dart';

class ResetPasswordCompleteScreen extends ConsumerWidget {
  const ResetPasswordCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      scrollBody: false,
      body: Stack(
        children: [
          Text(
            '단버리의\n비밀번호가 새롭게 설정되었어요',
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.check_rounded,
              color: Colors.green,
              size: 128,
            ),
          ),
        ],
      ),
      submitButton: OrbButton(
        onPressed: () async {
          ref.read(routerProvider).pop();
        },
        buttonText: '로그인하러 가기',
      ),
    );
  }
}
