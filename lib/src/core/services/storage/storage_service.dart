import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _box = GetStorage();

  static init() async {
    await GetStorage.init();
  }

}
