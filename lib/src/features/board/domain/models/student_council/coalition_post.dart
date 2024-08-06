import 'package:json_annotation/json_annotation.dart';

import 'coalition_type.dart';
import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';

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
    super.files,
    super.images,
    super.views,
    super.mine,
    super.blinded,
    //나중에 search에서 넘겨주게 되면 required 쓰면 됨
    this.type = CoalitionType.food,
  });

  factory CoalitionPost.fromJson(Map<String, dynamic> json) =>
      _$CoalitionPostFromJson(json);

  Map<String, dynamic> toJson() => _$CoalitionPostToJson(this);
}
