
class PetitionModel{
  late int id;
  late String title;
  late String body;
  late String author;
  late String createdAt;
  late int likes;
  late int views;
  late String status;
  late String expiresAt;

  //late file -> image

  PetitionModel({
    id,
    title,
    body,
    author,
    createdDate,
    likes,
    views,
    status,
    expiresAt
  });

  PetitionModel.fromJson(Map<String, dynamic> json){
    id = json["id"] as int;
    title = json["title"] as String;
    body = json["body"] as String;
    author = json["author"] as String? ?? "익명";
    createdAt = json["createdAt"] as String;
    likes = json["likes"] as int;
    views = json["views"] as int;
    status = json["status"] as String;
    expiresAt = json["expiresAt"] as String;
  }

}
