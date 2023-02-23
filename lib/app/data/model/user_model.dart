import 'package:danvery/app/data/model/subject_model.dart';

class UserModel{
  final String name;
  final String major;
  final String studentNumber;
  final List<SubjectModel>? subjects;

  UserModel({
    this.subjects,
    required this.name,
    required this.major,
    required this.studentNumber
  });

}
