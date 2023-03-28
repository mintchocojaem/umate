import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';

class PetitionBoardModel{

  late int totalElements;
  late int page;
  late int size;
  late int totalPages;
  late bool last;
  late bool first;
  late bool hasNext;
  late List<PetitionPostModel> petitionPosts;

  PetitionBoardModel({
    petitionPostList,
    totalElements,
    page,
    size,
    totalPages,
    last,
    first,
    hasNext
  });

  PetitionBoardModel.fromJson(Map<String, dynamic> json) {
    petitionPosts = (json['content'] as List).map((e) => PetitionPostModel.fromJson(e)).toList();
    totalElements = json['totalElements'];
    page = json['page'];
    size = json['size'];
    totalPages = json['totalPages'];
    last = json['last'];
    first = json['first'];
    hasNext = json['hasNext'];
  }
}
