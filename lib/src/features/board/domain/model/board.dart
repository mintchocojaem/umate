import 'post.dart';

abstract class Board<T extends Post>{
  final List<T> content;
  final bool hasNext;
  final int totalPages;
  final int totalElements;
  final int page;
  final int size;
  final bool first;
  final bool last;

  Board({
    required this.content,
    required this.hasNext,
    required this.totalPages,
    required this.totalElements,
    required this.page,
    required this.size,
    required this.first,
    required this.last,
  });

Board<T> copyWith({
    List<T>? content,
    bool? hasNext,
    int? totalPages,
    int? totalElements,
    int? page,
    int? size,
    bool? first,
    bool? last,
  });
}
