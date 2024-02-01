import 'package:intl/intl.dart';

mixin class PetitionDateFormat {

  String dateFormatCompact(String dateTime) {
    final date = DateTime.parse(dateTime);
    return DateFormat('yy.MM.dd').format(date);
  }
}
