import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/configs.dart';

class App extends ConsumerWidget {
  const App({super.key});

  //orb snack bar 키 초기화 해줘야 함

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ref.watch(themeProvider).getThemeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(appRouterProvider).config(),
      scaffoldMessengerKey: OrbService.scaffoldMessengerKey,
    );
  }
}
