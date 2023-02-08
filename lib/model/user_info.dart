class UserInfo{
  final String name;
  final String major;
  final String studentNumber;
  UserInfo({
    required this.name,
    required this.major,
    required this.studentNumber
  });
  factory UserInfo.fromJson(Map<String,dynamic> json){
    return UserInfo(
      name: json["data"]["name"] as String,
      major: json["data"]["major"] as String,
      studentNumber: json["data"]["studentNumber"] as String
    );
  }
}
