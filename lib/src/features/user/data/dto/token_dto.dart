import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/token.dart';

part 'token_dto.g.dart';

@JsonSerializable()
@immutable
class TokenDTO extends DataMapper<Token> {
  final String accessToken;
  final String refreshToken;

  TokenDTO({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenDTO.fromJson(Map<String, dynamic> json) => _$TokenDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDTOToJson(this);

  @override
  Token mapToModel() {
    return Token(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
