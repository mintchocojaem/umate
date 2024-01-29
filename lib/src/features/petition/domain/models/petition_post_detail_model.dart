import 'package:freezed_annotation/freezed_annotation.dart';

import 'petition_statistic_model.dart';

part 'petition_post_detail_model.freezed.dart';

part 'petition_post_detail_model.g.dart';

@freezed
class PetitionPostDetailModel with _$PetitionPostDetailModel {
  const factory PetitionPostDetailModel({
    required int id,
    required String title,
    required String author,
    required String body,
    String? answer,
    required String createdAt,
    //required List<PostFile?> files,
    //required List<PostImage?> images,
    required String status,
    required String expiresAt,
    required int agreeCount,
    @Default([]) List<PetitionStatisticModel?> statisticList,
    required bool agree,
    required bool mine,
    required bool blinded,
  }) = _PetitionPostDetailModel;

  factory PetitionPostDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PetitionPostDetailModelFromJson(json);
}
