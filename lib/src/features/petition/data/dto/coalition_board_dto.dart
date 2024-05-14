import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/board.dart';
import '../../domain/models/coalition_post.dart';
import 'board _dto.dart';
import 'coalition_post_dto.dart';

part 'coalition_board_dto.g.dart';

@JsonSerializable()
class CoalitionBoardDTO extends BoardDTO<CoalitionPostDTO> {

  CoalitionBoardDTO({
    required super.content,
    required super.hasNext,
    required super.totalPages,
    required super.totalElements,
    required super.page,
    required super.size,
    required super.first,
    required super.last,
  });

  factory CoalitionBoardDTO.fromJson(Map<String, dynamic> json) =>
      _$CoalitionBoardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CoalitionBoardDTOToJson(this);

  @override
  Board<CoalitionPost> mapToModel() {
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
