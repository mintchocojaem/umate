import 'general_comment_model.dart';

class GeneralCommentListModel {
  late int totalElements;
  late int totalPages;
  late int size;
  late int page;
  late bool hasNext;
  late bool first;
  late bool last;
  late List<GeneralCommentModel> generalCommentList;

  GeneralCommentListModel({
    totalElements,
    totalPages,
    size,
    page,
    hasNext,
    first,
    last,
  });

  GeneralCommentListModel.fromJson(Map<String, dynamic> json) {
    totalElements = json["totalElements"] as int;
    totalPages = json["totalPages"] as int;
    generalCommentList = json["content"]
        .map<GeneralCommentModel>((json) => GeneralCommentModel.fromJson(json))
        .toList();
    size = json["size"] as int;
    page = json["page"] as int;
    hasNext = json["hasNext"] as bool;
    first = json["first"] as bool;
    last = json["last"] as bool;
  }
}
