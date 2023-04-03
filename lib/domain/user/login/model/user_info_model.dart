class UserInfoModel{
  late String userName;
  late String studentId;
  late String major;

  UserInfoModel({
    userName,
    studentId,
    major,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json){
    userName = json["studentName"] as String;
    studentId = json["studentId"] as String? ?? "????????";
    major = json["major"] as String;
  }
}
