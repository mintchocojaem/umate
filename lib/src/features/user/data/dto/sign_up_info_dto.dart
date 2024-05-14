import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/sign_up_info.dart';
import '../dto/student_dto.dart';

part 'sign_up_info_dto.g.dart';

@JsonSerializable()
@immutable
class SignUpInfoDTO extends DataMapper<SignUpInfo>{

  final String signupToken;
  final StudentDTO student;

  SignUpInfoDTO({
    required this.signupToken,
    required this.student,
  });

  factory SignUpInfoDTO.fromJson(Map<String, dynamic> json) => _$SignUpInfoDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpInfoDTOToJson(this);

  @override
  SignUpInfo mapToModel() {
    return SignUpInfo(
      signUpToken: signupToken,
      student: student.mapToModel(),
    );
  }

}