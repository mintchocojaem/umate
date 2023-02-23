
class PetitionModel{
  late int id;
  late String title;
  late String petitionStatus;
  late int commentCount;
  late bool blind;
  late int postHits;

  PetitionModel({
    id,
    title,
    petitionStatus,
    commentCount,
    blind,
    postHits
  });

  PetitionModel.fromJson(Map<String, dynamic> json){
    id = json["id"] as int;
    title = json["title"] as String;
    petitionStatus = json["petitionStatus"] as String;
    commentCount = json["commentCount"] as int;
    blind = json["blind"] as bool;
    postHits = json["postHits"] as int;
  }

}
