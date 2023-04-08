
class PetitionPostModel{
  int id;
  String title;
  String body;
  String author;
  String createdAt;
  int views;
  String status;
  String expiresAt;
  //late file -> image

  PetitionPostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.author,
    required this.createdAt,
    required this.views,
    required this.status,
    required this.expiresAt,
  });

  factory PetitionPostModel.fromJson(Map<String, dynamic> json) {
    return PetitionPostModel(
      id: json["id"] as int,
      title: json["title"] as String,
      body: json["body"] as String,
      author: json["author"] as String? ?? "익명",
      createdAt: json["createdAt"] as String,
      views: json["views"] as int? ?? 0,
      status: json["status"] as String,
      expiresAt: json["expiresAt"] as String,
    );
  }

}
