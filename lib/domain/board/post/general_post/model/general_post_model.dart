class GeneralPostModel{
  late int id;
  late String title;
  late String body;
  late String author;
  late String createdAt;
  //late files -> image
  late int likes;
  late bool liked;
  late int views;
  late int commentCount;

  GeneralPostModel({
    id,
    title,
    body,
    author,
    createdDate,
    views,
    likes,
    liked,
    commentCount
  });

  GeneralPostModel.fromJson(Map<String, dynamic> json){
    id = json["id"] as int;
    title = json["title"] as String;
    body = json["body"] as String;
    author = json["author"] as String? ?? "익명";
    createdAt = json["createdAt"] as String;
    views = json["views"] as int? ?? 0;
    likes = json["likes"] as int? ?? 0;
    liked = json["liked"] as bool? ?? false;
    commentCount = json["commentCount"] as int? ?? 0;
  }

}
