import 'package:danvery/core/date_rename/date_rename.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_statistic_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_tag_model.dart';

enum PetitionPostStatus {
  active,
  waiting,
  answered,
  expired,
}

extension PetitionPostStatusExtension on PetitionPostStatus {
  String get nameKR => ['청원 중', '대기 중', '답변 완료', '기간만료'][index];
  String get name => ['ACTIVE', 'WAITING', 'ANSWERED', 'EXPIRED'][index];
}

class PetitionPostModel {
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
  bool agree;
  List<PetitionTagModel> tag;
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
    required this.mine,
    required this.files,
    required this.agree,
    required this.tag,
    this.answer,
  });

  factory PetitionPostModel.fromJson(Map<String, dynamic> json) {
    return PetitionPostModel(
      id: json["id"] as int,
      title: json["title"] as String,
      body: (json["body"] as String).replaceAll("\n", "</br>"),
      author: json["author"] as String? ?? "익명",
      createdAt: (json["createdAt"] as String).substring(2, 10).replaceAll("-", "/"),
      expiresAt: (json["expiresAt"] as String).substring(2, 10).replaceAll("-", "/"),
      views: json["views"] as int? ?? 0,
      status: PetitionPostStatus.values
          .firstWhere((element) => element.name == json["status"] as String)
          .nameKR,
      agreeCount: json["agreeCount"] as int,
      statisticList: (json["statisticList"] as List? ?? [])
          .map((e) => PetitionStatisticModel.fromJson(e))
          .toList(),
      mine: json["mine"] as bool? ?? false,
      files: (json["files"] as List)
          .map((e) => FileModel.fromGeneralPostFile(e))
          .toList(),
      agree: json["agree"] as bool? ?? false,
      tag: (json["tag"] as List? ?? []).map((e) => e as Map).toList().isNotEmpty
          ? (json["tag"] as List).map((e) => PetitionTagModel.fromJson(e)).toList()
          : [PetitionTagModel(id: null, name: "미분류")],
      answer: json["answer"] as String?,
    );
  }
}
