import 'package:freezed_annotation/freezed_annotation.dart';

import 'petition_post_preview_model.dart';

part 'petition_board_model.freezed.dart';

part 'petition_board_model.g.dart';

@freezed
class PetitionBoardModel with _$PetitionBoardModel {
  const factory PetitionBoardModel({
    required List<PetitionPostPreviewModel> content,
    required bool hasNext,
    required int totalPages,
    required int totalElements,
    required int page,
    required int size,
    required bool first,
    required bool last,
  }) = _PetitionBoardModel;

  factory PetitionBoardModel.fromJson(Map<String, dynamic> json) =>
      _$PetitionBoardModelFromJson(json);
}
