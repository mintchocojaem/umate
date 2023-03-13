class RegisterModel {
  late String signupToken;
  late String studentName;
  late String studentId;
  late String major;

  RegisterModel({signupToken,studentName, studentId, major});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    signupToken = json["signupToken"];
    studentName = json["student"]['studentName'];
    studentId = json["student"]['studentId'];
    major = json["student"]['major'];
  }
}
