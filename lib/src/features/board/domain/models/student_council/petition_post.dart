import 'package:json_annotation/json_annotation.dart';

import 'petition_status.dart';
import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';

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
    super.files,
    super.images,
    super.views,
    super.mine,
    super.blinded,
    this.answer,
    //나중에 search에서 넘겨주게 되면 required 쓰면 됨
    this.status = PetitionStatus.active,
    //나중에 search에서 넘겨주게 되면 required 쓰면 됨
    this.expiresAt = '',
    this.agreeCount = 0,
    this.agree = false,
  });

  factory PetitionPost.fromJson(Map<String, dynamic> json) =>
      _$PetitionPostFromJson(json);

  Map<String, dynamic> toJson() => _$PetitionPostToJson(this);

}
