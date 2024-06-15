import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String studentId;
  final String username;
  final String nickname;
  final String age;
  final String gender;
  final String yearOfAdmission;
  final String major;
  final String department;
  final String phoneNumber;
  //profile image
  final int writePostCount;
  final int commentedPostCount;
  final int likePostCount;
  final int petitionCount;
  final int agreePetitionCount;
  final bool admin;
  final bool dkuChecked;

  UserInfo({
    required this.studentId,
    required this.username,
    required this.nickname,
    required this.age,
    required this.gender,
    required this.yearOfAdmission,
    required this.major,
    required this.department,
    required this.phoneNumber,
    this.writePostCount = 0,
    this.commentedPostCount = 0,
    this.likePostCount = 0,
    this.petitionCount = 0,
    this.agreePetitionCount = 0,
    this.admin = false,
    this.dkuChecked = false,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}