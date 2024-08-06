import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/storage/storage_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/login_token.dart';

part 'auth_local_repository.g.dart';

@riverpod
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository(
    storage: ref.watch(storageServiceProvider),
  );
}

class AuthLocalRepository extends LocalRepository {
  AuthLocalRepository({
    required super.storage,
  });

  void saveLoginToken({
    required LoginToken token,
  }) {
    final jsonString = jsonEncode(token.toJson());
    storage.write(
      'loginToken',
      jsonString,
    );
  }

  LoginToken? getLoginToken() {
    final jsonString = storage.read('loginToken');
    final json = jsonString != null ? jsonDecode(jsonString) : null;
    return json != null ? LoginToken.fromJson(json) : null;
  }

  String? getRefreshToken() {
    final loginToken = getLoginToken();
    return loginToken?.refreshToken;
  }

  void deleteLoginToken() {
    storage.remove('loginToken');
  }
}
