import 'package:danvery/core/date_rename/date_rename.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';

class UserPostModel {
  int id;
  String title;
  String author;
  String body;
  String createdAt;
  List<FileModel> files;
  int likes;
  int views;
  int commentCount;
  bool blind;

  UserPostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.createdAt,
    required this.likes,
    required this.views,
    required this.commentCount,
    required this.files,
    required this.blind,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(
      id: json["id"] as int,
      title: json["title"] as String,
      body: (json["body"] as String).replaceAll("\n", "</br>"),
      author: json["author"] as String? ?? "익명",
      createdAt: dateRename(json["createdAt"] as String),
      views: json["views"] as int? ?? 0,
      likes: json["likes"] as int? ?? 0,
      commentCount: json["commentCount"] as int? ?? 0,
      files: (json["files"] as List)
          .map((e) => FileModel.fromGeneralPostFile(e))
          .toList(),
      blind: json["blind"] as bool? ?? false,
    );
  }
}
