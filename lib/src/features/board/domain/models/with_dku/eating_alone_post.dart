import 'package:json_annotation/json_annotation.dart';

import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';
import 'recruited_user_info.dart';

part 'eating_alone_post.g.dart';

@JsonSerializable()
class EatingAlonePost extends Post {
  final String kakaoOpenChatLink;
  final String gender;
  final String major;
  final List<RecruitedUserInfo> recruitedUsers;
  final int recruitedCount;
  final bool applied;
  final String status;

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
    this.kakaoOpenChatLink = '',
    this.gender = '알 수 없음',
    this.major = '알 수 없음',
    this.recruitedUsers = const [],
    this.recruitedCount = 0,
    this.applied = false,
    required this.status,
  });

  factory EatingAlonePost.fromJson(Map<String, dynamic> json) =>
      _$EatingAlonePostFromJson(json);

  Map<String, dynamic> toJson() => _$EatingAlonePostToJson(this);
}
