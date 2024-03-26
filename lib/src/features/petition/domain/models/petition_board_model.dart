import 'package:flutter/foundation.dart';

import 'petition_post_model.dart';

@immutable
final class PetitionBoardModel {
  final List<PetitionPostModel> content;
  final bool hasNext;
  final int totalPages;
  final int totalElements;
  final int page;
  final int size;
  final bool first;
  final bool last;

  const PetitionBoardModel({
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
