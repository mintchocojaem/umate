import 'package:json_annotation/json_annotation.dart';

part 'login_token.g.dart';

@JsonSerializable()
class LoginToken {
  final String accessToken;
  final String refreshToken;

  LoginToken({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginToken.fromJson(Map<String, dynamic> json) =>
      _$LoginTokenFromJson(json);

  Map<String, dynamic> toJson() => _$LoginTokenToJson(this);
}
