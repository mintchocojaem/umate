class RouteData {
  final String name;
  final String path;
  final String fullPath;

  const RouteData({
    required this.name,
    required this.path,
    required this.fullPath,
  });
}

class RouteInfo {
  //error
  static RouteData error = const RouteData(
    name: 'error',
    path: 'error',
    fullPath: '/error',
  );
  //main
  static RouteData main = const RouteData(
    name: 'main',
    path: 'main',
    fullPath: '/main',
  );
  //home
  static RouteData home = RouteData(
    name: 'home',
    path: 'home',
    fullPath: '${main.fullPath}/home',
  );
  //timetable
  static RouteData timetable = RouteData(
    name: 'timetable',
    path: 'timetable',
    fullPath: '${main.fullPath}/timetable',
  );
  //board
  static RouteData board = RouteData(
    name: 'board',
    path: 'board',
    fullPath: '${main.fullPath}/board',
  );
  static RouteData petition = RouteData(
    name: 'petition',
    path: 'petition',
    fullPath: '${board.fullPath}/petition',
  );
  //profile
  static RouteData profile = RouteData(
    name: 'profile',
    path: 'profile',
    fullPath: '${main.fullPath}/profile',
  );
  //login
  static RouteData login = const RouteData(
    name: 'login',
    path: 'login',
    fullPath: '/login',
  );
  static RouteData loginHelp = RouteData(
    name: 'loginHelp',
    path: 'help',
    fullPath: '${login.fullPath}/help',
  );
  //signUp
  static RouteData signUp = RouteData(
    name: 'signUp',
    path: 'signUp',
    fullPath: '${login.fullPath}/signUp',
  );
  static RouteData signUpVerifyStudent = RouteData(
    name: 'signUpVerifyStudent',
    path: '${signUp.path}/verifyStudent',
    fullPath: '${signUp.fullPath}/verifyStudent',
  );
  static RouteData signUpAgree = RouteData(
    name: 'signUpAgree',
    path: '${signUp.path}/agree',
    fullPath: '${signUp.fullPath}/agree',
  );
  static RouteData signUpCheckInfo = RouteData(
    name: 'signUpCheckInfo',
    path: '${signUp.path}/checkInfo',
    fullPath: '${signUp.fullPath}/checkInfo',
  );
  static RouteData signUpVerifySMS = RouteData(
    name: 'signUpVerifySMS',
    path: '${signUp.path}/verifySMS',
    fullPath: '${signUp.fullPath}/verifySMS',
  );
  static RouteData signUpNickName = RouteData(
    name: 'signUpNickName',
    path: '${signUp.path}/nickName',
    fullPath: '${signUp.fullPath}/nickName',
  );
  static RouteData signUpPassword = RouteData(
    name: 'signUpPassword',
    path: '${signUp.path}/password',
    fullPath: '${signUp.fullPath}/password',
  );
  static RouteData signUpComplete = RouteData(
    name: 'signUpComplete',
    path: '${signUp.path}/complete',
    fullPath: '${signUp.fullPath}/complete',
  );
  //find
  static RouteData find = RouteData(
    name: 'find',
    path: 'find',
    fullPath: '${login.fullPath}/find',
  ); //not page
  static RouteData findUserId = RouteData(
    name: 'findUserId',
    path: '${find.path}/userId',
    fullPath: '${find.fullPath}/userId',
  );
  static RouteData findUserIdComplete = RouteData(
    name: 'findUserIdComplete',
    path: '${findUserId.path}/complete',
    fullPath: '${findUserId.fullPath}/complete',
  );
  static RouteData resetPassword = RouteData(
    name: 'resetPassword',
    path: '${find.path}/resetPassword',
    fullPath: '${find.fullPath}/resetPassword',
  );
  static RouteData sendSMStoResetPassword = RouteData(
    name: 'sendSMStoResetPassword',
    path: '${resetPassword.path}/sendSMS',
    fullPath: '${resetPassword.fullPath}/sendSMS',
  );
  static RouteData verifySMStoResetPassword = RouteData(
    name: 'verifySMStoResetPassword',
    path: '${resetPassword.path}/verifySMS',
    fullPath: '${resetPassword.fullPath}/verifySMS',
  );
  static RouteData resetPasswordComplete = RouteData(
    name: 'resetPasswordComplete',
    path: '${resetPassword.path}/complete',
    fullPath: '${resetPassword.fullPath}/complete',
  );
}
