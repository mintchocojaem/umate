import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/configs.dart';
import 'modules/modules.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: OrbService.navigatorKey,
      theme: ref.watch(themeProvider).getThemeMode,
      debugShowCheckedModeBanner: false,
      home: Router(
        routeInformationParser:
            ref.watch(routerProvider).routeInformationParser,
        routeInformationProvider:
            ref.watch(routerProvider).routeInformationProvider,
        routerDelegate: ref.watch(routerProvider).routerDelegate,
      ),
    );
  }
}
