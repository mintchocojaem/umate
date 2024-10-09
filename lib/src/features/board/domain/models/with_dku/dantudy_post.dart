import 'package:json_annotation/json_annotation.dart';

import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';

part 'dantudy_post.g.dart';

@JsonSerializable()
class DantudyPost extends Post {
  final String? tag;
  final int recruitedCount;

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
    this.tag,
  });

  factory DantudyPost.fromJson(Map<String, dynamic> json) =>
      _$DantudyPostFromJson(json);

  Map<String, dynamic> toJson() => _$DantudyPostToJson(this);
}
