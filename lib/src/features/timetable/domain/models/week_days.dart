import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum WeekDays {
  @JsonValue('MONDAY')
  monday(value: 'MONDAY', english: 'Monday', korean: '월'),
  @JsonValue('TUESDAY')
  tuesday(value: 'TUESDAY', english: 'Tuesday', korean: '화'),
  @JsonValue('WEDNESDAY')
  wednesday(value: 'WEDNESDAY', english: 'Wednesday', korean: '수'),
  @JsonValue('THURSDAY')
  thursday(value: 'THURSDAY', english: 'Thursday', korean: '목'),
  @JsonValue('FRIDAY')
  friday(value: 'FRIDAY', english: 'Friday', korean: '금'),
  @JsonValue('SATURDAY')
  saturday(value: 'SATURDAY', english: 'Saturday', korean: '토'),
  @JsonValue('SUNDAY')
  sunday(value: 'SUNDAY', english: 'Sunday', korean: '일');

  final String value;
  final String english;
  final String korean;

  const WeekDays({
    required this.value,
    required this.english,
    required this.korean,
  });
}
