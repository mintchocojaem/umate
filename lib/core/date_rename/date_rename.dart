
String dateRename(String date) {
  final DateTime now = DateTime.now();
  final DateTime dateTime = DateTime.parse(date);
  if (now.year == dateTime.year) {
    if (now.month == dateTime.month) {
      if (now.day == dateTime.day) {
        if (now.hour == dateTime.hour) {
          if (now.minute - dateTime.minute < 1) {
            return "방금 전";
          }
          return "${now.minute - dateTime.minute}분 전";
        }
        return "${now.hour - dateTime.hour}시간 전";
      }
    }
    return dateTime.toString().substring(5, 10).replaceAll("-", "/");
  }
  return dateTime.toString().substring(0, 10).replaceAll("-", "/");
}
