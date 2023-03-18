
class PetitionModel{
  late int id;
  late String title;
  late String body;
  late String createdAt;
  //late file -> image

  PetitionModel({
    id,
    title,
    body,
    createdDate,
  });

  PetitionModel.fromJson(Map<String, dynamic> json){
    id = json["id"] as int;
    title = json["title"] as String;
    body = json["body"] as String;
    createdAt = json["createdAt"] as String;
  }

}
