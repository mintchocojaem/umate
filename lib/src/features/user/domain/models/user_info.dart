class UserInfo {
  final String studentId;
  final String username;
  final String nickname;
  final String age;
  final String gender;

  //final String yearOfAdmission;
  final String major;
  final String department;
  final String phoneNumber;

  //profile image
  //final int writePostCount;
  //final int commentedPostCount;
  //final int likePostCount;
  //final int petitionCount;
  //final int agreePetitionCount;
  final bool admin;
  final bool dkuChecked;

  UserInfo({
    required this.studentId,
    required this.username,
    required this.nickname,
    required this.age,
    required this.gender,
    //required this.yearOfAdmission,
    required this.major,
    required this.department,
    required this.phoneNumber,
    //required this.writePostCount,
    //required this.commentedPostCount,
    //required this.likePostCount,
    //required this.petitionCount,
    //required this.agreePetitionCount,
    required this.admin,
    required this.dkuChecked,
  });
}
