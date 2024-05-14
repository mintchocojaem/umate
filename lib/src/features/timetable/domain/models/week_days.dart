enum WeekDays {
  monday(value: 'MONDAY', english: 'Monday', korean: '월'),
  tuesday(value: 'TUESDAY', english: 'Tuesday', korean: '화'),
  wednesday(value: 'WEDNESDAY', english: 'Wednesday', korean: '수'),
  thursday(value: 'THURSDAY', english: 'Thursday', korean: '목'),
  friday(value: 'FRIDAY', english: 'Friday', korean: '금'),
  saturday(value: 'SATURDAY', english: 'Saturday', korean: '토'),
  sunday(value: 'SUNDAY', english: 'Sunday', korean: '일');

  final String value;
  final String english;
  final String korean;

  const WeekDays({
    required this.value,
    required this.english,
    required this.korean,
  });

  static fromValue(String value) {
    switch (value) {
      case 'MONDAY':
        return WeekDays.monday;
      case 'TUESDAY':
        return WeekDays.tuesday;
      case 'WEDNESDAY':
        return WeekDays.wednesday;
      case 'THURSDAY':
        return WeekDays.thursday;
      case 'FRIDAY':
        return WeekDays.friday;
      case 'SATURDAY':
        return WeekDays.saturday;
      case 'SUNDAY':
        return WeekDays.sunday;
      default:
        return null;
    }
  }
}
