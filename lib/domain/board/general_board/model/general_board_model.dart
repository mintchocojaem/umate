import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';

class GeneralBoardModel{
  late int totalElements;
  late int page;
  late int size;
  late int totalPages;
  late bool last;
  late bool first;
  late bool hasNext;
  late List<GeneralPostModel> generalPostList;

  GeneralBoardModel({
    generalPostList,
    totalElements,
    page,
    size,
    totalPages,
    last,
    first,
    hasNext
  });

  GeneralBoardModel.fromJson(Map<String, dynamic> json) {
    generalPostList = (json['content'] as List).map((e) => GeneralPostModel.fromJson(e)).toList();
    totalElements = json['totalElements'];
    page = json['page'];
    size = json['size'];
    totalPages = json['totalPages'];
    last = json['last'];
    first = json['first'];
    hasNext = json['hasNext'];
  }

}
