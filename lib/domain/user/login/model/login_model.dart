class LoginModel{
  String accessToken;
  String refreshToken;
  String username;
  String nickname;
  String studentId;
  String major;
  String department;
  bool admin;

  LoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.username,
    required this.nickname,
    required this.studentId,
    required this.major,
    required this.department,
    required this.admin,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json){
    return LoginModel(
      accessToken: json["accessToken"] as String,
      refreshToken: json["refreshToken"] as String,
      username: json["username"] as String,
      nickname: json["nickname"] as String,
      studentId: json["studentId"] as String,
      major: json["major"] as String,
      department: json["department"] as String,
      admin: json["admin"] as bool,
    );
  }

}
