class PetitionStatisticModel{
  int agreeCount;
  String department;

  PetitionStatisticModel({required this.agreeCount, required this.department});

  factory PetitionStatisticModel.fromJson(Map<String, dynamic> json) {
    return PetitionStatisticModel(
      agreeCount: json["agreeCount"] as int,
      department: json["department"] as String,
    );
  }
}
