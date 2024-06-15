import 'package:json_annotation/json_annotation.dart';

import 'coalition_type.dart';
import 'post.dart';
import 'post_file.dart';
import 'post_image.dart';

part 'coalition_post.g.dart';

@JsonSerializable()
class CoalitionPost extends Post {

  @JsonKey(name: 'coalitionType')
  final CoalitionType type;

  CoalitionPost({
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
    required this.type,
  });

  factory CoalitionPost.fromJson(Map<String, dynamic> json) =>
      _$CoalitionPostFromJson(json);

  Map<String, dynamic> toJson() => _$CoalitionPostToJson(this);
}
