class UserInfoModel{
  String username;
  String nickname;
  String studentId;
  String major;
  String department;
  int writeCount;
  int commentCount;
  int likeCount;
  bool admin;
  String phoneNumber;

  UserInfoModel({
    required this.username,
    required this.nickname,
    required this.studentId,
    required this.major,
    required this.department,
    required this.admin,
    required this.writeCount,
    required this.commentCount,
    required this.likeCount,
    required this.phoneNumber,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json){
    return UserInfoModel(
      username: json["username"] as String,
      nickname: json["nickname"] as String,
      studentId: json["studentId"] as String,
      major: json["major"] as String,
      department: json["department"] as String,
      admin: json["admin"] as bool,
      writeCount: json["writePostCount"] as int? ?? 0,
      commentCount: json["commentedPostCount"] as int? ?? 0,
      likeCount: json["likedPostCount"] as int? ?? 0,
      phoneNumber: json["phoneNumber"] as String,
    );
  }

}
