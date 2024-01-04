class RouteData {
  final String path;
  final RouteData? parent;

  String get fullPath => parent == null ? path : '${parent!.fullPath}/$path';

  const RouteData({
    required this.path,
    this.parent,
  });
}

class RouteInfo {
  //error
  static RouteData error = const RouteData(
    path: '/error',
  );

  //main
  static RouteData main = const RouteData(
    path: '/main',
  );

  //home
  static RouteData home = RouteData(
    path: 'home',
    parent: main,
  );

  //timetable
  static RouteData timetable = RouteData(
    path: 'timetable',
    parent: main
  );
  static RouteData timetableSearch = RouteData(
    path: 'search',
    parent: timetable
  );

  //board
  static RouteData board = RouteData(
    path: 'board',
    parent: main,
  );
  static RouteData petitionDetail = RouteData(
    path: 'petition/detail',
    parent: board,
  );
  static RouteData petitionWrite = RouteData(
    path: 'petition/write',
    parent: board,
  );

  //profile
  static RouteData profile = RouteData(
    path: 'profile',
    parent: main,
  );
  static RouteData profileEdit = RouteData(
    path: 'edit',
    parent: profile,
  );
  static RouteData profileEditVerifySMS = RouteData(
    path: 'verifySMS',
    parent: profileEdit,
  );

  //login
  static RouteData login = const RouteData(
    path: '/login',
  );
  static RouteData loginHelp = RouteData(
    path: 'help',
    parent: login,
  );

  //signUp
  static RouteData signUpVerifyStudent = RouteData(
    path: 'signup/verifyStudent',
    parent: login,
  );
  static RouteData signUpAgree = RouteData(
    path: 'signup/agree',
    parent: login,
  );
  static RouteData signUpCheckInfo = RouteData(
    path: 'signup/checkInfo',
    parent: login,
  );
  static RouteData signUpVerifySMS = RouteData(
    path: 'signup/verifySMS',
    parent: login,
  );
  static RouteData signUpNickname = RouteData(
    path: 'signup/nickname',
    parent: login,
  );
  static RouteData signUpPassword = RouteData(
    path: 'signup/password',
    parent: login,
  );
  static RouteData signUpComplete = RouteData(
    path: 'signup/complete',
    parent: login,
  );

  //find
  static RouteData findUserId = RouteData(
    path: 'find/id',
    parent: loginHelp,
  );
  static RouteData findUserIdComplete = RouteData(
    path: 'find/id/complete',
    parent: loginHelp,
  );
  static RouteData sendSMStoResetPassword = RouteData(
    path: 'find/password/sendSMS',
    parent: loginHelp,
  );
  static RouteData verifySMStoResetPassword = RouteData(
    path: 'find/password/verifySMS',
    parent: loginHelp,
  );
  static RouteData resetPassword = RouteData(
    path: 'find/password/reset',
    parent: loginHelp,
  );
  static RouteData resetPasswordComplete = RouteData(
    path: 'find/password/complete',
    parent: loginHelp,
  );
}
