class PostInfo{
  final int id;
  final String title;
  final int postHits;
  final int commentCount;
  final String category;
  final String status;
  final int likeCount;

  PostInfo({
    required this.id,
    required this.title,
    required this.postHits,
    required this.commentCount,
    required this.category,
    required this.status,
    required this.likeCount
  });

  factory PostInfo.fromJson(Map<String, dynamic> json){
    return PostInfo(
        id: json["id"] as int,
        title: json["title"] as String,
        postHits: json["postHits"] as int,
        commentCount: json["commentCount"] as int,
        category: json["category"] as String,
        status: json["status"] as String,
        likeCount: json["likeCount"] as int
    );
  }

}
