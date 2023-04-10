class UserInfoModel{
  String username;
  String nickname;
  String studentId;
  String major;
  String department;
  bool admin;

  UserInfoModel({
    required this.username,
    required this.nickname,
    required this.studentId,
    required this.major,
    required this.department,
    required this.admin,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json){
    return UserInfoModel(
      username: json["username"] as String,
      nickname: json["nickname"] as String,
      studentId: json["studentId"] as String,
      major: json["major"] as String,
      department: json["department"] as String,
      admin: json["admin"] as bool,
    );
  }

}
