import 'package:json_annotation/json_annotation.dart';
import 'package:umate/src/features/board/domain/models/with_dku/recruited_user_info.dart';

import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';

part 'dantudy_post.g.dart';

@JsonSerializable()
class DantudyPost extends Post {
  final String tag;
  final String gender;
  final String major;
  final List<RecruitedUserInfo> recruitedUsers;
  final int recruitedCount;
  final String startTime;
  final String endTime;
  final bool applied;

  DantudyPost({
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
    this.tag = '',
    this.startTime = '',
    this.endTime = '',
    this.applied = false,
  });

  factory DantudyPost.fromJson(Map<String, dynamic> json) =>
      _$DantudyPostFromJson(json);

  Map<String, dynamic> toJson() => _$DantudyPostToJson(this);
}
