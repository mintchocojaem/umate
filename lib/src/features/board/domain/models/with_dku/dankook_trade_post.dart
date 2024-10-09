import 'package:json_annotation/json_annotation.dart';

import '../post.dart';
import '../post_file.dart';
import '../post_image.dart';

part 'dankook_trade_post.g.dart';

@JsonSerializable()
class DankookTradePost extends Post {
  final int price;
  final String tradePlace;
  final String status;

  DankookTradePost({
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
    required this.price,
    required this.tradePlace,
    required this.status,
  });

  factory DankookTradePost.fromJson(Map<String, dynamic> json) =>
      _$DankookTradePostFromJson(json);

  Map<String, dynamic> toJson() => _$DankookTradePostToJson(this);
}
