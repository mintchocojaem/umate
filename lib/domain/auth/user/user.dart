import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String studentId,
    required String username,
    required String nickname,
    required String yearOfAdmission,
    required String major,
    required String department,
    required String phoneNumber,
    required int writePostCount,
    required int commentedPostCount,
    required int likedPostCount,
    required int petitionCount,
    required int agreedPetitionCount,
    required bool admin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
