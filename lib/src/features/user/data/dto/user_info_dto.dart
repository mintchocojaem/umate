import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/user_info.dart';

part 'user_info_dto.g.dart';

@JsonSerializable()
class UserInfoDTO extends DataMapper<UserInfo> {
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
  final int? writePostCount;
  final int? commentedPostCount;
  final int? likePostCount;
  final int? petitionCount;
  final int? agreePetitionCount;
  final bool admin;
  final bool dkuChecked;

  UserInfoDTO({
    required this.studentId,
    required this.username,
    required this.nickname,
    required this.age,
    required this.gender,
    required this.yearOfAdmission,
    required this.major,
    required this.department,
    required this.phoneNumber,
    this.writePostCount,
    this.commentedPostCount,
    this.likePostCount,
    this.petitionCount,
    this.agreePetitionCount,
    required this.admin,
    required this.dkuChecked,
  });

  factory UserInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDTOToJson(this);

  @override
  UserInfo mapToModel() {
    // TODO: implement mapToModel
    return UserInfo(
      studentId: studentId,
      username: username,
      nickname: nickname,
      age: age,
      gender: gender,
      major: major,
      department: department,
      phoneNumber: phoneNumber,
      admin: admin,
      dkuChecked: dkuChecked,
    );
  }
}
