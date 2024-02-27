import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/sign_up_info_model.dart';
import '../dto/student_dto.dart';

part 'sign_up_info_dto.g.dart';

@JsonSerializable()
class SignUpInfoDto extends DataMapper<SignUpInfoModel>{

  final String signupToken;
  final StudentDto student;

  SignUpInfoDto({
    required this.signupToken,
    required this.student,
  });

  factory SignUpInfoDto.fromJson(Map<String, dynamic> json) => _$SignUpInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpInfoDtoToJson(this);

  @override
  SignUpInfoModel mapToModel() {
    return SignUpInfoModel(
      signUpToken: signupToken,
      student: student.mapToModel(),
    );
  }

}