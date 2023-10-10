import 'package:danvery/domain/domain.dart';
import 'package:get_storage/get_storage.dart';

enum DataKey {
  token,
}

extension DataKeyExtension on DataKey {
  String get value => toString();
}

class SharedPreference {
  static final GetStorage _box = GetStorage();

  static init() async {
    await GetStorage.init();
  }

  set token(Token? value) => value == null
      ? _box.remove(DataKey.token.value)
      : _box.write(DataKey.token.value, value);

  Token? get token => _box.read(DataKey.token.value);
}
