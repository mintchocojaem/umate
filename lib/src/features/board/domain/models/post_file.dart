import 'package:json_annotation/json_annotation.dart';

part 'post_file.g.dart';

@JsonSerializable()
class PostFile {
  final int id;
  final String url;
  final String originalName;
  final String mimeType;

  PostFile({
    required this.id,
    required this.url,
    this.originalName = 'unknown_file',
    required this.mimeType,
  });

  factory PostFile.fromJson(Map<String, dynamic> json) =>
      _$PostFileFromJson(json);

  Map<String, dynamic> toJson() => _$PostFileToJson(this);
}
