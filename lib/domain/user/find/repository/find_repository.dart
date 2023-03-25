import 'package:danvery/domain/user/find/provider/find_provider.dart';

class FindRepository{
  final FindProvider _findProvider;

  static final FindRepository _singleton = FindRepository.internal(FindProvider());

  FindRepository.internal(this._findProvider);

  factory FindRepository() => _singleton;

  Future<bool> sendId(String phoneNumber) async {
    return await _findProvider.sendId(phoneNumber);
  }
}
