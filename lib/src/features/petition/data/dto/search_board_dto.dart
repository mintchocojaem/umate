
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/board.dart';
import '../../domain/models/search_post.dart';
import 'board _dto.dart';
import 'search_post_dto.dart';

part 'search_board_dto.g.dart';

@JsonSerializable()
class SearchBoardDTO extends BoardDTO<SearchPostDTO> {

  SearchBoardDTO({
    required super.content,
    required super.hasNext,
    required super.page,
    required super.size,
    required super.totalElements,
    required super.totalPages,
    required super.first,
    required super.last,
  });

  factory SearchBoardDTO.fromJson(Map<String, dynamic> json) =>
      _$SearchBoardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBoardDTOToJson(this);

  @override
  Board<SearchPost> mapToModel() {
    // TODO: implement mapToModel
    return Board(
     content: content.map((e) => e.mapToModel()).toList(),
      hasNext: hasNext,
      page: page,
      size: size,
      totalElements: totalElements,
      totalPages: totalPages,
      first: first,
      last: last,
    );
  }
}
