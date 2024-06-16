class TimeFormat {
  final int hour;
  final int minute;

  const TimeFormat({
    required this.hour,
    required this.minute,
  });

  factory TimeFormat.fromDateTime(DateTime dateTime) {
    return TimeFormat(
      hour: dateTime.hour,
      minute: dateTime.minute,
    );
  }

  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute, 0);
  }

  @override
  String toString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  TimeFormat add(TimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime = DateTime(now.year, now.month, now.day, hour, minute, 0).add(
      Duration(
        hours: scheduleTimeFormat.hour,
        minutes: scheduleTimeFormat.minute,
      ),
    );
    return TimeFormat(
      hour: newTime.hour,
      minute: newTime.minute,
    );
  }

  TimeFormat subtract(TimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime =
    DateTime(now.year, now.month, now.day, hour, minute, 0).subtract(
      Duration(
        hours: scheduleTimeFormat.hour,
        minutes: scheduleTimeFormat.minute,
      ),
    );
    return TimeFormat(
      hour: newTime.hour,
      minute: newTime.minute,
    );
  }

  int inMinutes() {
    return hour * 60 + minute;
  }

  bool isAfter(TimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime = DateTime(now.year, now.month, now.day, hour, minute, 0);
    final compareTime = DateTime(now.year, now.month, now.day,
        scheduleTimeFormat.hour, scheduleTimeFormat.minute, 0);
    return newTime.isAfter(compareTime);
  }

  bool isAtSameMomentAs(TimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime = DateTime(now.year, now.month, now.day, hour, minute, 0);
    final compareTime = DateTime(now.year, now.month, now.day,
        scheduleTimeFormat.hour, scheduleTimeFormat.minute, 0);
    return newTime.isAtSameMomentAs(compareTime);
  }

  bool isBefore(TimeFormat scheduleTimeFormat) {
    final now = DateTime.now();
    final newTime = DateTime(now.year, now.month, now.day, hour, minute, 0);
    final compareTime = DateTime(now.year, now.month, now.day,
        scheduleTimeFormat.hour, scheduleTimeFormat.minute, 0);
    return newTime.isBefore(compareTime);
  }

}