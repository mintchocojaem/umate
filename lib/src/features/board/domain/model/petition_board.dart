import 'package:json_annotation/json_annotation.dart';

import 'board.dart';
import 'petition_post.dart';

part 'petition_board.g.dart';

@JsonSerializable()
class PetitionBoard extends Board<PetitionPost> {
  PetitionBoard({
    required super.content,
    required super.hasNext,
    required super.totalPages,
    required super.totalElements,
    required super.page,
    required super.size,
    required super.first,
    required super.last,
  });

  factory PetitionBoard.fromJson(Map<String, dynamic> json) =>
      _$PetitionBoardFromJson(json);

  Map<String, dynamic> toJson() => _$PetitionBoardToJson(this);

  @override
  PetitionBoard copyWith({
    List<PetitionPost>? content,
    bool? hasNext,
    int? totalPages,
    int? totalElements,
    int? page,
    int? size,
    bool? first,
    bool? last,
  }) {
    // TODO: implement copyWith
    return PetitionBoard(
      content: content ?? this.content,
      hasNext: hasNext ?? this.hasNext,
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      page: page ?? this.page,
      size: size ?? this.size,
      first: first ?? this.first,
      last: last ?? this.last,
    );
  }
}
