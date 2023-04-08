import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';

class PetitionBoardModel{

  int totalElements;
  int page;
  int size;
  int totalPages;
  bool last;
  bool first;
  bool hasNext;
  List<PetitionPostModel> petitionPosts;

  PetitionBoardModel({
    required this.totalElements,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.last,
    required this.first,
    required this.hasNext,
    required this.petitionPosts,
  });

  factory PetitionBoardModel.fromJson(Map<String, dynamic> json) {
    return PetitionBoardModel(
      totalElements: json["totalElements"] as int,
      page: json["page"] as int,
      size: json["size"] as int,
      totalPages: json["totalPages"] as int,
      last: json["last"] as bool,
      first: json["first"] as bool,
      hasNext: json["hasNext"] as bool,
      petitionPosts: (json["content"] as List).map((e) => PetitionPostModel.fromJson(e)).toList(),
    );
  }

}
