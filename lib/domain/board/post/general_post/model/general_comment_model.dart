class GeneralCommentModel {
  int id;
  String author;
  String text;
  String createdAt;
  bool mine;

  GeneralCommentModel({
    required this.id,
    required this.author,
    required this.text,
    required this.createdAt,
    required this.mine,
  });

  factory GeneralCommentModel.fromJson(Map<String, dynamic> json) {
    return GeneralCommentModel(
      id: json["id"] as int,
      author: json["author"] as String? ?? "익명",
      text: json["text"] as String,
      createdAt: json["createdAt"] as String,
      mine: json["mine"] as bool,
    );
  }
}
