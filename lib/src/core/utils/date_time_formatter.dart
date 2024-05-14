import 'package:intl/intl.dart';

mixin DateTimeFormatter {

  String dateFormatToRemaining(String dateTime) {
    final date = DateTime.parse(dateTime);
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    return difference > 0 ? 'D-$difference' : 'D-Day';
  }

  String dateFormatToCompact(String dateTime) {
    final date = DateTime.parse(dateTime);
    return DateFormat('yyyy.MM.dd').format(date);
  }

  String dateFormatToRelative(String dateTime) {
    final date = DateTime.parse(dateTime);
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return DateFormat('yyyy.MM.dd').format(date);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}
