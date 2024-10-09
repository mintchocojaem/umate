import 'package:json_annotation/json_annotation.dart';

import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';

part 'eating_alone_post.g.dart';

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

@JsonSerializable()
class EatingAlonePost extends Post {
  final int recruitedCount;
  final String gender;
  final String major;
  final List<RecruitedUserInfo> recruitedUsers;

  EatingAlonePost({
    required super.id,
    required super.title,
    required super.author,
    required super.body,
    required super.createdAt,
    super.files,
    super.images,
    super.views,
    super.mine,
    super.blinded,
    this.recruitedCount = 0,
    this.gender = '알 수 없음',
    this.major = '알 수 없음',
    this.recruitedUsers = const [],
  });

  factory EatingAlonePost.fromJson(Map<String, dynamic> json) =>
      _$EatingAlonePostFromJson(json);

  Map<String, dynamic> toJson() => _$EatingAlonePostToJson(this);
}
