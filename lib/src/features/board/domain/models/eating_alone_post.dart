import 'package:json_annotation/json_annotation.dart';

import 'post.dart';
import 'post_file.dart';
import 'post_image.dart';

part 'eating_alone_post.g.dart';

@JsonSerializable()
class EatingAlonePost extends Post {

  final int recruitedCount;

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
  });

  factory EatingAlonePost.fromJson(Map<String, dynamic> json) =>
      _$EatingAlonePostFromJson(json);

  Map<String, dynamic> toJson() => _$EatingAlonePostToJson(this);
}