import 'package:json_annotation/json_annotation.dart';

import 'petition_status.dart';
import 'post.dart';
import 'post_file.dart';
import 'post_image.dart';

part 'petition_post.g.dart';

@JsonSerializable()
class PetitionPost extends Post {
  final String? answer;
  final PetitionStatus status;
  final String expiresAt;
  final int agreeCount;
  final bool agree;

  PetitionPost({
    required super.id,
    required super.title,
    required super.author,
    required super.body,
    required super.createdAt,
    required super.files,
    required super.images,
    required super.views,
    required super.mine,
    required super.blinded,
    this.answer,
    required this.status,
    required this.expiresAt,
    this.agreeCount = 0,
    this.agree = false,
  });

  factory PetitionPost.fromJson(Map<String, dynamic> json) =>
      _$PetitionPostFromJson(json);

  Map<String, dynamic> toJson() => _$PetitionPostToJson(this);
}
