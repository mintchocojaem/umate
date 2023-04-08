
import 'package:danvery/domain/board/general_board/model/file.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_statistic_model.dart';

class PetitionPostModel{
  int id;
  String title;
  String body;
  String author;
  String createdAt;
  int views;
  bool mine;
  String? answer;
  String status;
  String expiresAt;
  int agreeCount;
  bool agreed;
  List<PetitionStatisticModel> statisticList;
  List<FileModel> files;

  PetitionPostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.createdAt,
    required this.views,
    required this.status,
    required this.expiresAt,
    required this.agreeCount,
    required this.statisticList,
    this.answer,
    required this.mine,
    required this.files,
    required this.agreed,
  });

  factory PetitionPostModel.fromJson(Map<String, dynamic> json) {
    return PetitionPostModel(
      id: json["id"] as int,
      title: json["title"] as String,
      body: json["body"] as String,
      author: json["author"] as String? ?? "익명",
      createdAt: json["createdAt"] as String,
      views: json["views"] as int? ?? 0,
      status: json["status"] as String,
      expiresAt: json["expiresAt"] as String,
      agreeCount: json["agreeCount"] as int,
      statisticList: (json["statisticList"] as List? ?? []).map((e) => PetitionStatisticModel.fromJson(e)).toList(),
      answer: json["answer"] as String?,
      mine: json["mine"] as bool? ?? false,
      files: (json["files"] as List).map((e) => FileModel.fromGeneralPostFile(e)).toList(),
      agreed: json["agreed"] as bool? ?? false,
    );
  }

}
