import 'general_comment_model.dart';

class GeneralCommentListModel {
  int totalElements;
  int totalPages;
  int size;
  int page;
  bool hasNext;
  bool first;
  bool last;
  List<GeneralCommentModel> generalComments;

  GeneralCommentListModel({
    required this.totalElements,
    required this.totalPages,
    required this.generalComments,
    required this.size,
    required this.page,
    required this.hasNext,
    required this.first,
    required this.last,
  });

  factory GeneralCommentListModel.fromJson(Map<String, dynamic> json) {
    return GeneralCommentListModel(
      totalElements: json["totalElements"] as int,
      totalPages: json["totalPages"] as int,
      generalComments: json["content"]
          .map<GeneralCommentModel>((json) => GeneralCommentModel.fromJson(json))
          .toList(),
      size: json["size"] as int,
      page: json["page"] as int,
      hasNext: json["hasNext"] as bool,
      first: json["first"] as bool,
      last: json["last"] as bool,
    );
  }

}
