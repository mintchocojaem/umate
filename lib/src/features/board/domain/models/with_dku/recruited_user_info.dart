import 'package:json_annotation/json_annotation.dart';

part 'recruited_user_info.g.dart';

@JsonSerializable()
class RecruitedUserInfo {
  final int id;
  final String nickname;
  final String majorName;

  RecruitedUserInfo({
    required this.id,
    required this.nickname,
    required this.majorName,
  });

  factory RecruitedUserInfo.fromJson(Map<String, dynamic> json) =>
      _$RecruitedUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$RecruitedUserInfoToJson(this);
}
