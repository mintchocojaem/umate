import 'package:danvery/core/date_rename/date_rename.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';

enum ReportCategory {
  profanity,
  fighting,
  advertisement,
  politics,
  pornography,
  inappropriate,
  fraud,
}

extension ReportCategoryExtension on ReportCategory {
  String get name => [
    "PROFANITY",
    "FISHING",
    "ADVERTISEMENT",
    "POLITICS",
    "PORNOGRAPHY",
    "INAPPROPRIATE_CONTENT",
    "FRAUD"
  ][index];

  String get nameKR => [
    "욕설/비하",
    "낚시/놀림/도배",
    "광고성 게시글",
    "정당, 정치인 비하 및 선거운동",
    "음란물/불건전한 만남 및 대화",
    "게시판 성격에 부적합",
    "유출/사칭/사기",
  ][index];

}

class GeneralPostModel {
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

  factory GeneralPostModel.fromJson(Map<String, dynamic> json) {
    return GeneralPostModel(
      id: json["id"] as int,
      title: json["title"] as String,
      body: (json["body"] as String).replaceAll("\n", "</br>"),
      author: json["author"] as String? ?? "익명",
      createdAt: dateRename(json["createdAt"] as String),
      views: json["views"] as int? ?? 0,
      mine: json["mine"] as bool? ?? false,
      likes: json["likes"] as int? ?? 0,
      liked: json["liked"] as bool? ?? false,
      commentCount: json["commentCount"] as int? ?? 0,
      files: (json["files"] as List)
          .map((e) => FileModel.fromGeneralPostFile(e))
          .toList(),
    );
  }
}
