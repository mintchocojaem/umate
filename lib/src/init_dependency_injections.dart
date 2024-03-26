import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/services/network/network_client_service.dart';

//services
final networkClientServiceProvider = Provider<NetworkClientService>((ref) {
  final networkService = NetworkClientService();
  return networkService;
});
