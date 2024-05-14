part of 'router_service.dart';

enum AppRoute {
  error,
  noInternet,
  login,
  findStudentId,
  findPassword,
  verifyStudent,
  signUpAgreePolicy,
  signUp,
  signUpComplete,
  home,
  noticeBoard,
  noticePost,
  coalitionBoard,
  coalitionPost,
  petitionBoard,
  petitionPost,
  petitionWrite,
  postSearch,
  timetable,
  searchLecture,
  addSchedule,
  scheduleInfo,
  profile;

  const AppRoute();

  String get path {
    switch (this) {
      case error:
        return '/error';
      case noInternet:
        return '/noInternet';
      case login:
        return '/login';
      case findStudentId:
        return '/login/findStudentId';
      case findPassword:
        return '/login/findPassword';
      case verifyStudent:
        return '/login/signUp/verifyStudent';
      case signUpAgreePolicy:
        return '/login/signUp/agreePolicy';
      case signUp:
        return '/login/signUp';
      case signUpComplete:
        return '/login/signUp/complete';
      case home:
        return '/home';
      case noticeBoard:
        return '/board/notice';
      case noticePost:
        return '/board/notice/post/:id';
      case coalitionBoard:
        return '/board/coalition';
      case coalitionPost:
        return '/board/coalition/post/:id';
      case petitionBoard:
        return '/board/petition';
      case petitionPost:
        return '/board/petition/post/:id';
      case petitionWrite:
        return '/board/petition/write';
      case postSearch:
        return '/search';
      case timetable:
        return '/timetable';
      case searchLecture:
        return '/timetable/searchLecture';
      case addSchedule:
        return '/timetable/addSchedule';
      case scheduleInfo:
        return '/timetable/scheduleInfo/:id';
      case profile:
        return '/profile';
    }
  }
}
