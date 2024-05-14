import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/board.dart';
import '../../domain/models/notice_post.dart';
import 'board _dto.dart';
import 'notice_post_dto.dart';

part 'notice_board_dto.g.dart';

@JsonSerializable()
class NoticeBoardDTO extends BoardDTO<NoticePostDTO>{

  NoticeBoardDTO({
    required super.content,
    required super.hasNext,
    required super.totalPages,
    required super.totalElements,
    required super.page,
    required super.size,
    required super.first,
    required super.last,
  });

  factory NoticeBoardDTO.fromJson(Map<String, dynamic> json) =>
      _$NoticeBoardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeBoardDTOToJson(this);

  @override
  Board<NoticePost> mapToModel() {
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