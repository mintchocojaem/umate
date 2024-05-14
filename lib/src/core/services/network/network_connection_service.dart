import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../router/router_service.dart';

final networkConnectionServiceProvider =
    Provider<NetworkConnectionService>((ref) {
  final networkService = NetworkConnectionService(
    onDisconnected: () {
      final routerService = ref.read(routerServiceProvider);
      final currentRoute = routerService
          .routerDelegate.currentConfiguration.lastOrNull?.matchedLocation;
      if (currentRoute != null &&
          !currentRoute.contains(AppRoute.noInternet.path)) {
        routerService.pushNamed(AppRoute.noInternet.name, closeKeyboard: false);
      }
    },
    onConnected: () {
      final routerService = ref.read(routerServiceProvider);
      final currentRoute = routerService
          .routerDelegate.currentConfiguration.lastOrNull?.matchedLocation;
      if (currentRoute != null &&
          currentRoute.contains(AppRoute.noInternet.path)) {
        routerService.pop(closeKeyboard: false);
      }
    },
  );
  networkService.init();
  ref.onDispose(() {
    networkService.dispose();
  });
  return networkService;
});

class NetworkConnectionService {
  late final StreamSubscription<InternetConnectionStatus> subscription;

  final void Function() onConnected;
  final void Function() onDisconnected;

  NetworkConnectionService({
    required this.onConnected,
    required this.onDisconnected,
  }) {
    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      if (kDebugMode) {
        print('NetworkConnectionService > State : $status');
      }
      switch (status) {
        case InternetConnectionStatus.connected:
          onConnected();
          break;
        case InternetConnectionStatus.disconnected:
          onDisconnected();
          break;
      }
    });
  }

  void init() {
    InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 5),
      checkInterval: const Duration(seconds: 5),
    );
  }

  void dispose() {
    subscription.cancel();
  }
}
