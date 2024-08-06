import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

@riverpod
StorageService storageService(StorageServiceRef ref) {
  return StorageService();
}

class StorageService {
  final GetStorage _box = GetStorage();

  static init() async {
    await GetStorage.init();
  }

  void write(String key, dynamic value) {
    _box.write(key, value);
    if (kDebugMode) {
      print('StorageService > (write) key: $key, value: $value');
    }
  }

  dynamic read(String key) {
    final result = _box.read(key);
    if (kDebugMode) {
      print('StorageService > (read) key: $key, value: $result');
    }
    return result;
  }

  void remove(String key) {
    _box.remove(key);
    if (kDebugMode) {
      print('StorageService > (remove) key: $key');
    }
  }
}
