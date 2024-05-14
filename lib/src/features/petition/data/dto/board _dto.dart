
import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/board.dart';
import 'post_dto.dart';

abstract class BoardDTO<A extends PostDTO> extends DataMapper<Board> {
  final List<A> content;
  final bool hasNext;
  final int totalPages;
  final int totalElements;
  final int page;
  final int size;
  final bool first;
  final bool last;

  BoardDTO({
    required this.content,
    required this.hasNext,
    required this.totalPages,
    required this.totalElements,
    required this.page,
    required this.size,
    required this.first,
    required this.last,
  });
}
