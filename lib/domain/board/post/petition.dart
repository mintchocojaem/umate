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
class File with _$File {
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
class Petition with _$Petition {
  const factory Petition({
    required int id,
    required String title,
    required String author,
    required String body,
    String? answer,
    required String createdAt,
    required List<File?> files,
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
