class TimetableListModel{
  List<TimetableInfo> timetables;

  TimetableListModel({
    required this.timetables,
  });

  factory TimetableListModel.fromJson(List<dynamic> json) {
    return TimetableListModel(
      timetables: json.map((e) => TimetableInfo.fromJson(e)).toList(),
    );
  }
}

class TimetableInfo{
  int id;
  String name;

  TimetableInfo({
    required this.id,
    required this.name,
  });

  factory TimetableInfo.fromJson(Map<String, dynamic> json) {
    return TimetableInfo(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
