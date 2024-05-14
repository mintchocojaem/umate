enum CoalitionType{
  food(
    displayName: "음식/카페",
    value: "FOOD",
  ),
  culture(
    displayName: "문화/교육",
    value: "CULTURE",
  ),
  health(
    displayName: "뷰티/헬스",
    value: "HEALTH",
  ),
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