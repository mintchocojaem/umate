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