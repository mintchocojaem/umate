enum ScheduleType {
  schedule(value: 'SCHEDULE'),
  lecture(value: 'LECTURE');

  final String value;

  const ScheduleType({
    required this.value,
  });

  static ScheduleType fromValue(String value) {
    switch (value) {
      case 'SCHEDULE':
        return ScheduleType.schedule;
      case 'LECTURE':
        return ScheduleType.lecture;
      default:
        throw Exception('Invalid value');
    }
  }
}
