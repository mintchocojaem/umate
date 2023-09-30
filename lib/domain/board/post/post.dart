import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class File with _$File{
  const factory File({
    required int id,
    required String url,
    required String thumbnailUrl,
    required String originalName,
    required String mimeType,
  }) = _File;

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);
}

@freezed
class Post with _$Post {
  const factory Post({
    required int id,
    required String title,
    required String author,
    required String body,
    String? answer,
    required String createdAt,
    required List<File?> files,
    required String status,
    required String expiresAt,
    required int agreeCount,
    required bool blinded,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
