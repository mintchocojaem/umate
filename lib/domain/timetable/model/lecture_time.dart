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
      start: json['start'] as String,
      end: json['end'] as String,
      week: json['week'] as String,
      place: json['place'] as String?,
    );
  }

}
