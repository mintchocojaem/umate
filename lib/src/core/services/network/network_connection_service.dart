import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../router/router_service.dart';

final networkConnectionServiceProvider =
    Provider<NetworkConnectionService>((ref) {
  final networkService = NetworkConnectionService(
    ref,
  );
  networkService.init();
  return networkService;
});

class NetworkConnectionService {
  final Ref ref;
  final Connectivity _connectivity = Connectivity();
  final StreamController _networkConnectionController =
      StreamController<bool>.broadcast();
  late final Timer _timer;

  NetworkConnectionService(this.ref);

  bool beforeInternetConnection = false;
  bool currentInternetConnection = false;

  int _count = 0;

  Future<void> init() async {
    beforeInternetConnection = await _getInternetConnection();
    currentInternetConnection = await _getInternetConnection();

    Timer.periodic(const Duration(seconds: 5), (timer) async {
      final result = await _getInternetConnection();
      _networkConnectionController.add(result);
    });

    _networkConnectionController.stream.listen((value) async {
      if (beforeInternetConnection != value) {
        beforeInternetConnection = currentInternetConnection;
        currentInternetConnection = value;

        if (kDebugMode) {
          print(
              'NetworkConnectionService[$_count] > Internet Connection : ($beforeInternetConnection) -> ($currentInternetConnection)');
          _count++;
        }
      }

      if (currentInternetConnection == false &&
          beforeInternetConnection == false) {
        _goToNoInternetScreen();
      } else if (currentInternetConnection == true &&
          beforeInternetConnection == true) {
        _popNoInternetScreen();
      }
    });
  }

  void dispose() {
    _networkConnectionController.close();
    _timer.cancel();
  }

  Future<bool> _getInternetConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }
  }

  void _goToNoInternetScreen() {
    final routerService = ref.read(routerServiceProvider);
    if (routerService.current.name != const NoInternetRoute().routeName) {
      routerService.push(const NoInternetRoute());
    }
  }

  void _popNoInternetScreen() {
    //여기 점검
    final routerService = ref.read(routerServiceProvider);
    if (routerService.current.name == const NoInternetRoute().routeName) {
      routerService.pop();
    }
  }
}
