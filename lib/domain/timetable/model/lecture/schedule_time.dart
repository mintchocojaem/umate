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

class ScheduleTime{
  String start;
  String end;
  WeekOfDay week;
  String? place;

  ScheduleTime({
    required this.start,
    required this.end,
    required this.week,
    this.place
  });

  factory ScheduleTime.fromJson(Map<String, dynamic> json) {
    return ScheduleTime(
      start: (json['start'] as String).substring(0,5),
      end: (json['end'] as String).substring(0,5),
      week: WeekOfDay.values.firstWhere((element) => element.name == json['week']),
      place: (json['place'] as String?)
    );
  }

  Map<String, dynamic> toJson() => {
    'start': "$start:00",
    'end': "$end:00",
    'week': week.name,
    'place': place,
  };

}
