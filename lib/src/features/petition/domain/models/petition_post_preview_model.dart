import 'package:freezed_annotation/freezed_annotation.dart';

part 'petition_post_preview_model.freezed.dart';

part 'petition_post_preview_model.g.dart';

@freezed
class PetitionPostPreviewModel with _$PetitionPostPreviewModel {
  const factory PetitionPostPreviewModel({
    required int id,
    required String title,
    required String author,
    required String createdAt,
    //required List<PostFile?> files,
    //required List<PostImage?> images,
    required String status,
    required String expiresAt,
    required int agreeCount,
    required bool blinded,
  }) = _PetitionPostPreviewModel;

  factory PetitionPostPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$PetitionPostPreviewModelFromJson(json);
}
