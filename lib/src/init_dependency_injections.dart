import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/services/network/network_client_service.dart';
import 'core/services/router/router_service.dart';
import 'core/services/storage/storage_service.dart';
import 'features/user/presentation/providers/states/login_state.dart';
import 'features/user/user_dependency_injections.dart';

//services
final networkClientServiceProvider = Provider<NetworkClientService>(
  (ref) {
    return NetworkClientService(
      onRequest: (options) async {
        final loginState = ref.read(loginProvider);

        final storageService = ref.read(storageServiceProvider);

        final token = storageService.read('token');

        if (loginState is LoginSuccessState) {
          options.headers.addAll({
            'Authorization': 'Bearer ${loginState.token.accessToken}',
          });
        } else if (token != null) {
          options.headers.addAll({
            'Authorization': 'Bearer ${token['accessToken']}',
          });
        }

        await Future.delayed(const Duration(milliseconds: 100));
      },
      onResponse: (response) async {
      },
      onError: (exception) async {
        //if student verify failed
        if(exception.response?.statusCode == 600){
          ref.read(routerServiceProvider).goNamed(
            AppRoute.verifyStudent.name,
            queryParameters: {
              'isExpired': 'true',
            },
          );
        }
      },
    );
  },
);

final storageServiceProvider = Provider<StorageService>(
  (ref) {
    return StorageService();
  },
);
