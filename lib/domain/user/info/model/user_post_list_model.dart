
import 'package:danvery/domain/user/info/model/user_post_model.dart';

class UserPostListModel{
  int totalElements;
  int page;
  int size;
  int totalPages;
  bool last;
  bool first;
  bool hasNext;
  List<UserPostModel> userPosts;

  UserPostListModel({
    required this.totalElements,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.last,
    required this.first,
    required this.hasNext,
    required this.userPosts,
  });

  factory UserPostListModel.fromJson(Map<String, dynamic> json) {
    return UserPostListModel(
      totalElements: json['totalElements'],
      page: json['page'],
      size: json['size'],
      totalPages: json['totalPages'],
      last: json['last'],
      first: json['first'],
      hasNext: json['hasNext'],
      userPosts: (json['content'] as List).map((e) => UserPostModel.fromJson(e)).toList(),
    );
  }

}
