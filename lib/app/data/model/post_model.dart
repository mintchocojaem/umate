class PostModel{
  late int id;
  late String title;
  late String body;
  //late String createdAt;
  //late files -> image
  late int views;
  //late int comments;

  PostModel({
    id,
    title,
    body,
    createdDate,
    views,
    comments
  });

  PostModel.fromJson(Map<String, dynamic> json){
    id = json["id"] as int;
    title = json["title"] as String;
    body = json["body"] as String;
    //createdAt = json["createdAt"] as String;
    views = json["views"] as int;
    //comments = json["comments"] as int;
  }

}
