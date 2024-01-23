import 'package:danvery/src/features/auth/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'student_model.dart';

part 'sign_up_model.freezed.dart';
part 'sign_up_model.g.dart';

@freezed
class SignUpModel with _$SignUpModel{
  const factory SignUpModel({
    @JsonKey(name: 'signupToken') required String signUpToken,
    required StudentModel student,
  }) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);
}