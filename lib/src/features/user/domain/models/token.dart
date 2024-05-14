import 'package:flutter/foundation.dart';

@immutable
final class Token{
  final String accessToken;
  final String refreshToken;

  const Token({
    required this.accessToken,
    required this.refreshToken,
  });
}