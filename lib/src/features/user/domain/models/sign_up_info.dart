import 'package:json_annotation/json_annotation.dart';

import 'student_info.dart';

part 'sign_up_info.g.dart';

@JsonSerializable()
class SignUpInfo {
  final String signupToken;
  final StudentInfo studentInfo;

  SignUpInfo({
    required this.signupToken,
    required this.studentInfo,
  });

  factory SignUpInfo.fromJson(Map<String, dynamic> json) =>
      _$SignUpInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpInfoToJson(this);
}


