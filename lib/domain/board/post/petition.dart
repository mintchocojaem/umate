import 'package:freezed_annotation/freezed_annotation.dart';

part 'petition.freezed.dart';
part 'petition.g.dart';

@freezed
class Agree with _$Agree {
  const factory Agree({
    required String department,
    required int agreeCount,
  }) = _Agree;

  factory Agree.fromJson(Map<String, dynamic> json) => _$AgreeFromJson(json);
}

@freezed
class File with _$File {
  const factory File({
    required int id,
    required String url,
    required String thumbnailUrl,
    required String originalName,
    required String mimeType,
  }) = _File;

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);
}

@freezed
class Petition with _$Petition {
  const factory Petition({
    required int id,
    required String title,
    required String author,
    required String body,
    String? answer,
    required String createdAt,
    required List<File?> files,
    required PetitionStatus status,
    required String expiresAt,
    required int agreeCount,
    List<Agree?>? statisticList,
    @Default(false) bool agree,
    @Default(false) bool mine,
    required bool blinded,
  }) = _Petition;

  factory Petition.fromJson(Map<String, dynamic> json) => _$PetitionFromJson(json);
}

sealed class PetitionStatus {

  final String name;
  final String value;

  const PetitionStatus._(this.name, this.value);

  const factory PetitionStatus.active() = _Active;
  const factory PetitionStatus.waiting() = _Waiting;
  const factory PetitionStatus.answered() = _Answered;
  const factory PetitionStatus.expired() = _Expired;

  factory PetitionStatus.fromJson(String json) {
    switch (json) {
      case "ACTIVE":
        return const PetitionStatus.active();
      case "WAITING":
        return const PetitionStatus.waiting();
      case "ANSWERED":
        return const PetitionStatus.answered();
      case "EXPIRED":
        return const PetitionStatus.expired();
      default:
        return const PetitionStatus.active();
    }
  }

  String toJson() => value;

  @override
  toString() => value;

}

class _Active extends PetitionStatus {
  const _Active() : super._("청원 중", "ACTIVE");
}

class _Waiting extends PetitionStatus {
  const _Waiting() : super._("대기 중", "WAITING");
}

class _Answered extends PetitionStatus {
  const _Answered() : super._("답변 완료", "ANSWERED");
}

class _Expired extends PetitionStatus {
  const _Expired() : super._("기간 만료", "EXPIRED");
}
