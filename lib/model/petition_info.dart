
class PetitionInfo{
  final int id;
  final String title;
  final String petitionStatus;
  final int commentCount;
  final bool blind;
  final int postHits;

  PetitionInfo({
    required this.title,
    required this.id,
    required this.petitionStatus,
    required this.commentCount,
    required this.blind,
    required this.postHits
  });

  factory PetitionInfo.fromJson(Map<String, dynamic> json){
    return PetitionInfo(
        id: json["id"] as int,
        title: json["title"] as String,
        postHits: json["postHits"] as int,
        commentCount: json["commentCount"] as int,
        blind: json["blind"] as bool,
        petitionStatus: json["petitionStatus"] as String
    );
  }

}
