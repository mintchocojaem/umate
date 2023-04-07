class UserInfoModel{
  String username;
  String nickname;
  String studentId;
  String major;
  String department;
  String yearOfAdmission;

  UserInfoModel({
    required this.username,
    required this.nickname,
    required this.studentId,
    required this.major,
    required this.department,
    required this.yearOfAdmission,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json){
    return UserInfoModel(
      username: json["username"] as String,
      nickname: json["nickname"] as String,
      studentId: json["studentId"] as String,
      major: json["major"] as String,
      department: json["department"] as String,
      yearOfAdmission: json["yearOfAdmission"] as String,
    );
  }

}
