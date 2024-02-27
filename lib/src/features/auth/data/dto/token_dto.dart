import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/token_model.dart';

part 'token_dto.g.dart';

@JsonSerializable()
class TokenDto extends DataMapper<TokenModel> {
  final String accessToken;
  final String refreshToken;

  TokenDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDtoToJson(this);

  @override
  TokenModel mapToModel() {
    return TokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

}
