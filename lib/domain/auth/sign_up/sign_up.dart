import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up.freezed.dart';
part 'sign_up.g.dart';

@freezed
class SignUp with _$SignUp {
  const factory SignUp({
    @JsonKey(name : "signupToken") required String signUpToken,
    required Student student,
  }) = _SignUp;

  factory SignUp.fromJson(Map<String, dynamic> json) => _$SignUpFromJson(json);
}

@freezed
class Student with _$Student {
  const factory Student({
    required String studentName,
    required String studentId,
    required String major,
  }) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
