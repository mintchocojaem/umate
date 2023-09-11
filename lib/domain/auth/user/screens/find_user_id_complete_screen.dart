import 'package:danvery/routes/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modules/orb/components/components.dart';

class FindUserIdCompleteScreen extends ConsumerWidget {
  const FindUserIdCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return OrbScaffold(
      pageHelpText: '입력하신 휴대폰\n번호로 아이디를 전송했어요',
      body: const Expanded(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.check_rounded,
                color: Colors.green,
                size: 128,
              ),
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () {
          ref.read(routerProvider).pop();
        },
        child: const Text('로그인하러 가기'),
      ),
    );
  }
}
