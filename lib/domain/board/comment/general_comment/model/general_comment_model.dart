class GeneralCommentModel{
  late int id;
  late String author;
  late String text;
  late String createdAt;
  late bool mine;

  GeneralCommentModel({
    id,
    author,
    text,
    createdAt,
    mine,
  });

  GeneralCommentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] as int;
    author = json["author"] as String? ?? "익명";
    text = json["text"] as String;
    createdAt = json["createdAt"] as String;
    mine = json["mine"] as bool;
  }
}
