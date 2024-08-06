import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'status')
enum PetitionStatus {
  @JsonValue('ACTIVE')
  active(value: 'ACTIVE', korean: '진행 중'),
  @JsonValue('WAITING')
  waiting(value: 'WAITING', korean: '대기 중'),
  @JsonValue('ANSWERED')
  answered(value: 'ANSWERED', korean: '답변 완료'),
  @JsonValue('EXPIRED')
  expired(value: 'EXPIRED', korean: '기간 만료');

  final String value;
  final String korean;

  const PetitionStatus({
    required this.value,
    required this.korean,
  });

  static PetitionStatus fromValue(String value) {
    switch (value) {
      case 'ACTIVE':
        return PetitionStatus.active;
      case 'WAITING':
        return PetitionStatus.waiting;
      case 'ANSWERED':
        return PetitionStatus.answered;
      case 'EXPIRED':
        return PetitionStatus.expired;
      default:
        throw Exception('Unknown value: $value');
    }
  }
}
