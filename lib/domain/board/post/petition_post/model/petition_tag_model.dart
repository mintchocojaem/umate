class PetitionTagModel{
  int? id;
  String name;

  PetitionTagModel({required this.id, required this.name});

  factory PetitionTagModel.fromJson(Map<String, dynamic> json) {
    return PetitionTagModel(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }
}
