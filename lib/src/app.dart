import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/services/network/network_connection_service.dart';
import 'core/services/router/router_service.dart';
import 'design_system/orb/orb.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final navigator = ref.watch(routerServiceProvider);

    ref.watch(networkConnectionServiceProvider);

    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: OrbTheme(
        child: Router(
          routerDelegate: navigator.routerDelegate,
          routeInformationParser: navigator.routeInformationParser,
          routeInformationProvider: navigator.routeInformationProvider,
          backButtonDispatcher: navigator.backButtonDispatcher,
        ),
      ),
    );
  }
}
