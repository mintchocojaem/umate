import 'general_comment_model.dart';

class GeneralCommentListModel{
  late int totalElements;
  late int totalPages;
  late List<GeneralCommentModel> generalCommentList;


  GeneralCommentListModel({
    totalElements,
    totalPages,
    generalCommentList
  });

  GeneralCommentListModel.fromJson(Map<String, dynamic> json) {
    totalElements = json["totalElements"] as int;
    totalPages = json["totalPages"] as int;
    generalCommentList = json["content"]
        .map<GeneralCommentModel>((json) => GeneralCommentModel.fromJson(json)).toList();
  }

}
