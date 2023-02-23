class PostModel{
  late int id;
  late String title;
  late int postHits;
  late int commentCount;
  late String category;
  late String status;
  late int likeCount;

  PostModel({
    id,
    title,
    postHits,
    commentCount,
    category,
    status,
    likeCount
  });

  PostModel.fromJson(Map<String, dynamic> json){
    id = json["id"] as int;
    title = json["title"] as String;
    postHits = json["postHits"] as int;
    commentCount = json["commentCount"] as int;
    category = json["category"] as String;
    status = json["status"] as String;
    likeCount = json["likeCount"] as int;
  }

}
