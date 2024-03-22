import 'package:flutter/foundation.dart';

@immutable
final class TokenModel{
  final String accessToken;
  final String refreshToken;

  const TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });
}