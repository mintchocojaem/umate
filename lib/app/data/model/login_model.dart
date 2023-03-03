class LoginModel{
  late String accessToken;
  late String refreshToken;
  late String userName;
  late String studentId;
  late String major;
  late String department;
  late bool admin;

  LoginModel({
    accessToken,
    refreshToken,
    userName,
    studentId,
    major,
    department,
    admin
  });

  LoginModel.fromJson(Map<String, dynamic> json){
    accessToken = json["accessToken"] as String;
    refreshToken = json["refreshToken"] as String;
    userName = json["userName"] as String;
    studentId = json["studentId"] as String;
    major = json["major"] as String;
    department = json["department"] as String;
    admin = json["admin"] as bool;
  }

}
