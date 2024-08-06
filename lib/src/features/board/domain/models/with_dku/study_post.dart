import 'package:json_annotation/json_annotation.dart';

import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';

part 'study_post.g.dart';

@JsonSerializable()
class StudyPost extends Post {

  final String? tag;
  final int recruitedCount;

  StudyPost({
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
    this.tag,
  });

  factory StudyPost.fromJson(Map<String, dynamic> json) =>
      _$StudyPostFromJson(json);

  Map<String, dynamic> toJson() => _$StudyPostToJson(this);
}