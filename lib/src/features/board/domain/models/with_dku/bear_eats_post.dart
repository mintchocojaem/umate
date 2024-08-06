import 'package:json_annotation/json_annotation.dart';

import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';

part 'bear_eats_post.g.dart';

@JsonSerializable()
class BearEatsPost extends Post {
  final String restaurant;
  final String deliveryPlace;
  final String deliveryTime;
  final int recruitedCount;

  BearEatsPost({
    required super.id,
    //required super.title,
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
    required this.recruitedCount,
  }) : super(title: "\"$restaurant\" 같이 먹어요");

  factory BearEatsPost.fromJson(Map<String, dynamic> json) =>
      _$BearEatsPostFromJson(json);

  Map<String, dynamic> toJson() => _$BearEatsPostToJson(this);
}
