class RouteData {
  final RouteData? _parent;
  final String _path;

  const RouteData({
    RouteData? parent,
    required String path,
  })  : _parent = parent,
        _path = path;

  String get path => _parent != null ? _path.replaceFirst('/', '') : _path;

  String get fullPath {
    if (_parent != null) {
      return '${_parent.fullPath}/$path';
    }
    return path;
  }
}

class RouteInfo {
  //error
  static const RouteData error = RouteData(
    path: '/error',
  );

  //login
  static const RouteData login = RouteData(
    path: '/login',
  );
  static const RouteData loginHelp = RouteData(
    parent: login,
    path: '/help',
  );
  //login/sign_up
  static const RouteData signUpVerifyStudent = RouteData(
    parent: login,
    path: '/signUp/verify/student',
  );
  static const RouteData signUpAgreement = RouteData(
    parent: login,
    path: '/signUp/agreement',
  );
  static const RouteData signUpCheckInfo = RouteData(
    parent: login,
    path: '/signUp/checkInfo',
  );
  static const RouteData signUpVerifySMS = RouteData(
    parent: login,
    path: '/signUp/verify/sms',
  );
  static const RouteData signUpNickname = RouteData(
    parent: login,
    path: '/signUp/nickname',
  );
  static const RouteData signUpPassword = RouteData(
    parent: login,
    path: '/signUp/password',
  );
  static const RouteData signUpComplete = RouteData(
    parent: login,
    path: '/signUp/complete',
  );

  //main
  static const RouteData main = RouteData(
    path: '/main',
  );

  //home
  static const RouteData home = RouteData(
    parent: main,
    path: '/home',
  );
}
