import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/services/router/router_service.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerServiceProvider);

    return MaterialApp.router(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: router.navigator,
    );
  }
}
