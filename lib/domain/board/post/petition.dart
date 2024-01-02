import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'petition.freezed.dart';
part 'petition.g.dart';

@freezed
class Agree with _$Agree {
  const factory Agree({
    required String department,
    required int agreeCount,
  }) = _Agree;

  factory Agree.fromJson(Map<String, dynamic> json) => _$AgreeFromJson(json);
}

@freezed
class PostImage with _$PostImage {
  const factory PostImage({
    required int id,
    required String url,
    required String thumbnailUrl,
    required String originalName,
    required String mimeType,
  }) = _PostImage;

  factory PostImage.fromJson(Map<String, dynamic> json) => _$PostImageFromJson(json);
}

@freezed
class PostFile with _$PostFile {
  const factory PostFile({
    required int id,
    required String url,
    required String originalName,
    required String mimeType,
  }) = _PostFile;

  factory PostFile.fromJson(Map<String, dynamic> json) => _$PostFileFromJson(json);
}

@freezed
class Petition with _$Petition {
  const factory Petition({
    required int id,
    required String title,
    required String author,
    required String body,
    String? answer,
    required String createdAt,
    required List<PostFile?> files,
    required List<PostImage?> images,
    required PetitionStatus status,
    required String expiresAt,
    required int agreeCount,
    List<Agree?>? statisticList,
    @Default(false) bool agree,
    @Default(false) bool mine,
    required bool blinded,
  }) = _Petition;

  factory Petition.fromJson(Map<String, dynamic> json) => _$PetitionFromJson(json);
}