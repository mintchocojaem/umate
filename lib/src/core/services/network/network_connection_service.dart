import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../router/router_service.dart';

final networkConnectionServiceProvider = Provider<NetworkConnectionService>(
  (ref) {
    final networkService = NetworkConnectionService(
      onNetworkConnectionFailed: () {
        final routerService = ref.read(routerServiceProvider);
        if (routerService.current.name != const NoInternetRoute().routeName) {
          routerService.push(const NoInternetRoute());
        }
      },
      onNetworkConnectionSuccess: () {
        final routerService = ref.read(routerServiceProvider);
        if (routerService.current.name == const NoInternetRoute().routeName) {
          routerService.pop();
        }
      },
    );
    ref.onDispose(() {
      networkService.dispose();
    });
    return networkService;
  },
);

typedef OnNetworkConnectionFailed = void Function();

typedef OnNetworkConnectionSuccess = void Function();

class NetworkConnectionService {
  final OnNetworkConnectionFailed onNetworkConnectionFailed;
  final OnNetworkConnectionSuccess onNetworkConnectionSuccess;

  final _connectivity = Connectivity();
  final _networkConnectionController = StreamController<bool>.broadcast();

  bool _beforeInternetState = false;
  bool _currentInternetState = false;

  NetworkConnectionService({
    required this.onNetworkConnectionFailed,
    required this.onNetworkConnectionSuccess,
  }) {
    _init();
  }

  Future<void> _init() async {
    _beforeInternetState = await _getInternetConnection();
    _currentInternetState = await _getInternetConnection();

    Timer.periodic(const Duration(seconds: 5), (timer) async {
      final result = await _getInternetConnection();
      _networkConnectionController.add(result);
    });

    _networkConnectionController.stream.listen((value) async {
      if (_beforeInternetState != value) {
        _beforeInternetState = _currentInternetState;
        _currentInternetState = value;

        if (kDebugMode) {
          print(
              'NetworkConnectionService > Internet Connection : ($_beforeInternetState) -> ($_currentInternetState)');
        }
      }

      if (_currentInternetState == false && _beforeInternetState == false) {
        onNetworkConnectionFailed();
      } else if (_currentInternetState == true &&
          _beforeInternetState == true) {
        onNetworkConnectionSuccess();
      }
    });
  }

  void dispose() {
    _networkConnectionController.close();
  }

  Future<bool> _getInternetConnection() async {
    return await _connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.wifi ||
          value == ConnectivityResult.mobile) {
        return true;
      } else {
        return false;
      }
    });
  }
}
