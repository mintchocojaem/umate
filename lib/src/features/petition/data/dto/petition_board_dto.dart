import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/board.dart';
import '../../domain/models/petition_post.dart';
import 'board _dto.dart';
import 'petition_post_dto.dart';

part 'petition_board_dto.g.dart';

@JsonSerializable()
class PetitionBoardDTO extends BoardDTO<PetitionPostDTO> {

  PetitionBoardDTO({
    required super.content,
    required super.hasNext,
    required super.page,
    required super.size,
    required super.totalElements,
    required super.totalPages,
    required super.first,
    required super.last,
  });

  factory PetitionBoardDTO.fromJson(Map<String, dynamic> json) =>
      _$PetitionBoardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PetitionBoardDTOToJson(this);

  @override
  Board<PetitionPost> mapToModel() {
    // TODO: implement mapToModel
    return Board(
      content: content.map((e) => e.mapToModel()).toList(),
      hasNext: hasNext,
      totalPages: totalPages,
      totalElements: totalElements,
      page: page,
      size: size,
      first: first,
      last: last,
    );
  }
}
