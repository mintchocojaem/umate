import 'package:json_annotation/json_annotation.dart';

import 'post.dart';
import 'post_file.dart';
import 'post_image.dart';

part 'notice_post.g.dart';

@JsonSerializable()
class NoticePost extends Post {
  NoticePost({
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
  });

  factory NoticePost.fromJson(Map<String, dynamic> json) =>
      _$NoticePostFromJson(json);

  Map<String, dynamic> toJson() => _$NoticePostToJson(this);
}
