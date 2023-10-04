import 'package:danvery/domain/board/post/petition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'board.freezed.dart';
part 'board.g.dart';

@freezed
class Board with _$Board {
  const factory Board({
    required List<Petition> content,
    required bool hasNext,
    required int totalPages,
    required int totalElements,
    required int page,
    required int size,
    required bool first,
    required bool last,
  }) = _Board;

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
}
