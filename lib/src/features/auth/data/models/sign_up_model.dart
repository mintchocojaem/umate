import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/domain.dart';
import '../data.dart';

part 'sign_up_model.freezed.dart';
part 'sign_up_model.g.dart';

@freezed
class SignUpModel extends SignUpEntity with _$SignUpModel{
  const factory SignUpModel({
    @JsonKey(name: 'signupToken') required String signUpToken,
    required StudentModel student,
  }) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);
}