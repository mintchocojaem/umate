import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/time_format.dart';
import 'week_days.dart';

part 'schedule_time.g.dart';

@JsonSerializable()
class ScheduleTime {
  @JsonKey(fromJson: _parseTimeFromJson, toJson: _parseTimeToJson)
  final TimeFormat start;
  @JsonKey(fromJson: _parseTimeFromJson, toJson: _parseTimeToJson)
  final TimeFormat end;
  @JsonKey(name: "week")
  final WeekDays day;
  final String place;

  const ScheduleTime({
    required this.start,
    required this.end,
    required this.day,
    this.place = '',
  });

  factory ScheduleTime.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTimeToJson(this);
}

TimeFormat _parseTimeFromJson(String time) =>
    TimeFormat.fromDateTime(DateFormat('HH:mm:ss').parse(time));

String _parseTimeToJson(TimeFormat time) =>
    DateFormat('HH:mm:ss').format(time.toDateTime());
