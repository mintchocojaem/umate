import 'package:json_annotation/json_annotation.dart';

import 'post_file.dart';

part 'post_image.g.dart';

@JsonSerializable()
class PostImage extends PostFile {
  final String thumbnailUrl;

  PostImage({
    required super.id,
    required super.url,
    required super.originalName,
    required super.mimeType,
    required this.thumbnailUrl,
  });

  factory PostImage.fromJson(Map<String, dynamic> json) =>
      _$PostImageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostImageToJson(this);
}
