import 'package:danvery/core/date_rename/date_rename.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';

enum PostType {voc, news, rule, petition, conference, generalForum}

extension PostTypeExtension on PostType {
  String get title {
    switch (this) {
      case PostType.voc:
        return "Voc";
      case PostType.news:
        return "News";
      case PostType.rule:
        return "Rule";
      case PostType.petition:
        return "Petition";
      case PostType.conference:
        return "Conference";
      case PostType.generalForum:
        return "GeneralForum";
    }
  }
}

class UserPostModel {
  int id;
  String title;
  String body;
  String author;
  String createdAt;
  int likes;
  bool mine;
  bool liked;
  int views;
  int commentCount;
  List<FileModel> files;
  PostType postType;

  UserPostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.createdAt,
    required this.likes,
    required this.mine,
    required this.liked,
    required this.views,
    required this.commentCount,
    required this.files,
    required this.postType,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(
      id: json["id"] as int,
      title: json["title"] as String,
      body: json["body"] as String,
      author: json["author"] as String? ?? "익명",
      createdAt: dateRename((json["createdAt"] as String)),
      views: json["views"] as int? ?? 0,
      mine: json["mine"] as bool? ?? false,
      likes: json["likes"] as int? ?? 0,
      liked: json["liked"] as bool? ?? false,
      commentCount: json["commentCount"] as int? ?? 0,
      files: (json["files"] as List)
          .map((e) => FileModel.fromGeneralPostFile(e))
          .toList(),
      postType: PostType.values.firstWhere(
          (element) => element.title == json["postType"] as String),
    );
  }
}
