class RegisterModel {
  String signupToken;
  String studentName;
  String studentId;
  String major;
  String? nickname;
  String? password;
  String? phone;

  RegisterModel({
    required this.signupToken,
    required this.studentName,
    required this.studentId,
    required this.major,
    this.nickname,
    this.password,
    this.phone,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json){
    return RegisterModel(
      signupToken: json["signupToken"],
      studentName: json["student"]['studentName'],
      studentId: json["student"]['studentId'],
      major: json["student"]['major'],
    );
  }

}
