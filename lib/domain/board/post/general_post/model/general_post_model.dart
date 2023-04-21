import 'package:danvery/core/date_rename/date_rename.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';

class GeneralPostModel{
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

  GeneralPostModel({
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
  });

  factory GeneralPostModel.fromJson(Map<String, dynamic> json){
    return GeneralPostModel(
      id: json["id"] as int,
      title: json["title"] as String,
      body: json["body"] as String,
      author: json["author"] as String? ?? "익명",
      createdAt: dateRename(json["createdAt"] as String),
      views: json["views"] as int? ?? 0,
      mine: json["mine"] as bool? ?? false,
      likes: json["likes"] as int? ?? 0,
      liked: json["liked"] as bool? ?? false,
      commentCount: json["commentCount"] as int? ?? 0,
      files: (json["files"] as List).map((e) => FileModel.fromGeneralPostFile(e)).toList(),
    );
  }

}
