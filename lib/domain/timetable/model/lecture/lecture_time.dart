enum WeekOfDay {
  monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

extension WeekOfDayExtension on WeekOfDay {
  String get nameKR => [
    '월',
    '화',
    '수',
    '목',
    '금',
    '토',
    '일',
  ][index];
  String get name => [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ][index];
}

class LectureTime{
  String start;
  String end;
  String week;
  String? place;

  LectureTime({
    required this.start,
    required this.end,
    required this.week,
    this.place
  });

  factory LectureTime.fromJson(Map<String, dynamic> json) {
    return LectureTime(
      start: (json['start'] as String).substring(0,5),
      end: (json['end'] as String).substring(0,5),
      week: WeekOfDay.values.firstWhere((element) => element.name == json['week']).nameKR,
      place: (json['place'] as String?)
    );
  }

  Map<String, dynamic> toJson() => {
    'start': "$start:00",
    'end': "$end:00",
    'week': WeekOfDay.values.firstWhere((element) => element.nameKR == week).name,
    'place': place,
  };

}
