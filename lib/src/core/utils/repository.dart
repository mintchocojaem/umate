import '../services/network/network_client_service.dart';
import '../services/storage/storage_service.dart';

class RemoteRepository {
  final NetworkClientService client;

  RemoteRepository({
    required this.client,
  });
}

class LocalRepository {
  final StorageService storage;

  LocalRepository({
    required this.storage,
  });
}
