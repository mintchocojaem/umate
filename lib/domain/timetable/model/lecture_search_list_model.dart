import 'lecture_search_model.dart';

class LectureSearchListModel{
  final bool hasNext;
  final int totalPages;
  final int totalElements;
  final int page;
  final int size;
  final bool first;
  final bool last;
  List<LectureSearchModel> content;

  LectureSearchListModel({
    required this.content,
    required this.hasNext,
    required this.totalPages,
    required this.totalElements,
    required this.page,
    required this.size,
    required this.first,
    required this.last
  });

  factory LectureSearchListModel.fromJson(Map<String, dynamic> json) {
    return LectureSearchListModel(
      hasNext: json['hasNext'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
      first: json['first'] as bool,
      last: json['last'] as bool,
      content: (json['content'] as List? ?? []).map((e) => LectureSearchModel.fromJson(e)).toList()
    );
  }
}
