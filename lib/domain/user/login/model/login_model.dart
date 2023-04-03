class LoginModel{
  late String accessToken;
  late String refreshToken;
  late String userName;
  late String studentId;
  late String major;

  LoginModel({
    accessToken,
    refreshToken,
    userName,
    studentId,
    major,
  });

  LoginModel.fromJson(Map<String, dynamic> json){
    accessToken = json["accessToken"] as String;
    refreshToken = json["refreshToken"] as String;
    userName = json["userName"] as String;
    studentId = json["studentId"] as String;
    major = json["major"] as String;
  }

}

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
