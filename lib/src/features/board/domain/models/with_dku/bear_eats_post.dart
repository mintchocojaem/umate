import 'package:json_annotation/json_annotation.dart';

import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';
import 'recruited_user_info.dart';

part 'bear_eats_post.g.dart';

@JsonSerializable()
class BearEatsPost extends Post {
  final String restaurant;
  final String deliveryPlace;
  final String deliveryTime;
  final List<RecruitedUserInfo> recruitedUsers;
  final int recruitedCount;
  final bool applied;
  final String gender;
  final String major;

  BearEatsPost({
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
    required this.restaurant,
    required this.deliveryPlace,
    required this.deliveryTime,
    this.recruitedUsers = const [],
    required this.recruitedCount,
    this.applied = false,
    this.gender = '알 수 없음',
    this.major = '알 수 없음',
  });

  factory BearEatsPost.fromJson(Map<String, dynamic> json) =>
      _$BearEatsPostFromJson(json);

  Map<String, dynamic> toJson() => _$BearEatsPostToJson(this);
}
