import 'package:flutter/foundation.dart';

@immutable
final class Student {
  final String studentName;
  final String studentId;
  final String major;
  final int age;
  final String gender;

  const Student({
    required this.studentName,
    required this.studentId,
    required this.major,
    required this.age,
    required this.gender,
  });

}
