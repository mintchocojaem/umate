import 'package:freezed_annotation/freezed_annotation.dart';

import 'student_model.dart';

part 'sign_up_model.freezed.dart';
part 'sign_up_model.g.dart';

@freezed
class SignUpModel with _$SignUpModel {
  const factory SignUpModel({
    required String signUpToken,
    required StudentModel student,
    String? validPhoneNumber,
    String? validNickname,
  }) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);
}