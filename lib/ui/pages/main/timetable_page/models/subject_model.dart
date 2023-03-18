class SubjectModel{
  final String name;
  final String? code;
  final String startTime;
  final String endTime;
  final String? professor;
  final String? credit;
  final String? dept;
  final List<String> days;

  SubjectModel({
    this.code,
    required this.startTime,
    required this.endTime,
    this.professor,
    this.credit,
    this.dept,
    required this.name,
    required this.days
  });

}
