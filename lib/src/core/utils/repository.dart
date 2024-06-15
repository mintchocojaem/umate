import '../services/network/network_client_service.dart';
import '../services/storage/storage_service.dart';

class RemoteRepository {
  final NetworkClientService networkClientService;

  RemoteRepository({
    required this.networkClientService,
  });
}

class LocalRepository {
  final StorageService storageService;

  LocalRepository({
    required this.storageService,
  });
}
