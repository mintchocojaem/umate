class PostModel{
  late int id;
  late String title;
  late String body;
  late String author;
  late String createdAt;
  //late files -> image
  late int likes;
  late int views;
  late int comments;

  PostModel({
    id,
    title,
    body,
    author,
    createdDate,
    views,
    likes,
    comments
  });

  PostModel.fromJson(Map<String, dynamic> json){
    id = json["id"] as int;
    title = json["title"] as String;
    body = json["body"] as String;
    author = json["author"] as String? ?? "익명";
    createdAt = json["createdAt"] as String;
    views = json["views"] as int;
    likes = json["likes"] as int;
    comments = json["comments"] as int? ?? 0;
  }

}
