import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'coalitionType')
enum CoalitionType{
  @JsonValue("FOOD")
  food(
    displayName: "음식/카페",
    value: "FOOD",
  ),
  @JsonValue("CULTURE")
  culture(
    displayName: "문화/교육",
    value: "CULTURE",
  ),
  @JsonValue("HEALTH")
  health(
    displayName: "뷰티/헬스",
    value: "HEALTH",
  ),
  @JsonValue("ETC")
  etc(
    displayName: "기타",
    value: "ETC",
  );

  final String displayName;
  final String value;

  const CoalitionType({
    required this.displayName,
    required this.value,
  });
}