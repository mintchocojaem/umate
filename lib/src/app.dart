import 'package:danvery/src/core/services/router/router_service.dart';
import 'package:danvery/src/design_system/orb/orb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/services/theme/theme_service.dart';

class App extends ConsumerWidget {
  const App({super.key});

  //orb snack bar 키 초기화 해줘야 함

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ref.watch(themeServiceProvider).getThemeMode(),
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerServiceProvider).config(),
      scaffoldMessengerKey: OrbService.scaffoldMessengerKey,
    );
  }
}
