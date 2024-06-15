import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/storage/storage_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/login_token.dart';

final authLocalRepositoryProvider = Provider.autoDispose<AuthLocalRepository>(
  (ref) => AuthLocalRepository(
    storageService: ref.watch(storageServiceProvider),
  ),
);

class AuthLocalRepository extends LocalRepository {
  AuthLocalRepository({
    required super.storageService,
  });

  void saveLoginToken({
    required LoginToken token,
  }) {
    final jsonString = jsonEncode(token.toJson());
    storageService.write(
      'loginToken',
      jsonString,
    );
  }

  LoginToken? getLoginToken() {
    final jsonString = storageService.read('loginToken');
    final json = jsonString != null ? jsonDecode(jsonString) : null;
    return json != null ? LoginToken.fromJson(json) : null;
  }

  void deleteLoginToken() {
    storageService.remove('loginToken');
  }
}
