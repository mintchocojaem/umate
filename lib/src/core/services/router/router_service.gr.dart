// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router_service.dart';

abstract class _$RouterService extends RootStackRouter {
  // ignore: unused_element
  _$RouterService({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginHelpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginHelpScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    NoInternetRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NoInternetScreen(),
      );
    },
    RouteErrorRoute.name: (routeData) {
      final args = routeData.argsAs<RouteErrorRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RouteErrorScreen(
          key: args.key,
          errorMessage: args.errorMessage,
        ),
      );
    },
    SignUpCompleteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpCompleteScreen(),
      );
    },
    SignUpNicknameRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpNicknameRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpNicknameScreen(
          key: args.key,
          signUpToken: args.signUpToken,
        ),
      );
    },
    SignUpPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpPasswordRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpPasswordScreen(
          key: args.key,
          signUpToken: args.signUpToken,
          nickname: args.nickname,
        ),
      );
    },
    SignUpPolicyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPolicyScreen(),
      );
    },
    SignUpSendCodeRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpSendCodeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpSendCodeScreen(
          key: args.key,
          signUpToken: args.signUpToken,
          student: args.student,
        ),
      );
    },
    SignUpVerifyCodeRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpVerifyCodeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpVerifyCodeScreen(
          key: args.key,
          signUpToken: args.signUpToken,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    SignUpVerifyStudentRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpVerifyStudentScreen(),
      );
    },
  };
}

/// generated route for
/// [LoginHelpScreen]
class LoginHelpRoute extends PageRouteInfo<void> {
  const LoginHelpRoute({List<PageRouteInfo>? children})
      : super(
          LoginHelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginHelpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NoInternetScreen]
class NoInternetRoute extends PageRouteInfo<void> {
  const NoInternetRoute({List<PageRouteInfo>? children})
      : super(
          NoInternetRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoInternetRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RouteErrorScreen]
class RouteErrorRoute extends PageRouteInfo<RouteErrorRouteArgs> {
  RouteErrorRoute({
    Key? key,
    required String errorMessage,
    List<PageRouteInfo>? children,
  }) : super(
          RouteErrorRoute.name,
          args: RouteErrorRouteArgs(
            key: key,
            errorMessage: errorMessage,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteErrorRoute';

  static const PageInfo<RouteErrorRouteArgs> page =
      PageInfo<RouteErrorRouteArgs>(name);
}

class RouteErrorRouteArgs {
  const RouteErrorRouteArgs({
    this.key,
    required this.errorMessage,
  });

  final Key? key;

  final String errorMessage;

  @override
  String toString() {
    return 'RouteErrorRouteArgs{key: $key, errorMessage: $errorMessage}';
  }
}

/// generated route for
/// [SignUpCompleteScreen]
class SignUpCompleteRoute extends PageRouteInfo<void> {
  const SignUpCompleteRoute({List<PageRouteInfo>? children})
      : super(
          SignUpCompleteRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpCompleteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpNicknameScreen]
class SignUpNicknameRoute extends PageRouteInfo<SignUpNicknameRouteArgs> {
  SignUpNicknameRoute({
    Key? key,
    required String signUpToken,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpNicknameRoute.name,
          args: SignUpNicknameRouteArgs(
            key: key,
            signUpToken: signUpToken,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpNicknameRoute';

  static const PageInfo<SignUpNicknameRouteArgs> page =
      PageInfo<SignUpNicknameRouteArgs>(name);
}

class SignUpNicknameRouteArgs {
  const SignUpNicknameRouteArgs({
    this.key,
    required this.signUpToken,
  });

  final Key? key;

  final String signUpToken;

  @override
  String toString() {
    return 'SignUpNicknameRouteArgs{key: $key, signUpToken: $signUpToken}';
  }
}

/// generated route for
/// [SignUpPasswordScreen]
class SignUpPasswordRoute extends PageRouteInfo<SignUpPasswordRouteArgs> {
  SignUpPasswordRoute({
    Key? key,
    required String signUpToken,
    required String nickname,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpPasswordRoute.name,
          args: SignUpPasswordRouteArgs(
            key: key,
            signUpToken: signUpToken,
            nickname: nickname,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpPasswordRoute';

  static const PageInfo<SignUpPasswordRouteArgs> page =
      PageInfo<SignUpPasswordRouteArgs>(name);
}

class SignUpPasswordRouteArgs {
  const SignUpPasswordRouteArgs({
    this.key,
    required this.signUpToken,
    required this.nickname,
  });

  final Key? key;

  final String signUpToken;

  final String nickname;

  @override
  String toString() {
    return 'SignUpPasswordRouteArgs{key: $key, signUpToken: $signUpToken, nickname: $nickname}';
  }
}

/// generated route for
/// [SignUpPolicyScreen]
class SignUpPolicyRoute extends PageRouteInfo<void> {
  const SignUpPolicyRoute({List<PageRouteInfo>? children})
      : super(
          SignUpPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpPolicyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpSendCodeScreen]
class SignUpSendCodeRoute extends PageRouteInfo<SignUpSendCodeRouteArgs> {
  SignUpSendCodeRoute({
    Key? key,
    required String signUpToken,
    required StudentModel student,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpSendCodeRoute.name,
          args: SignUpSendCodeRouteArgs(
            key: key,
            signUpToken: signUpToken,
            student: student,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpSendCodeRoute';

  static const PageInfo<SignUpSendCodeRouteArgs> page =
      PageInfo<SignUpSendCodeRouteArgs>(name);
}

class SignUpSendCodeRouteArgs {
  const SignUpSendCodeRouteArgs({
    this.key,
    required this.signUpToken,
    required this.student,
  });

  final Key? key;

  final String signUpToken;

  final StudentModel student;

  @override
  String toString() {
    return 'SignUpSendCodeRouteArgs{key: $key, signUpToken: $signUpToken, student: $student}';
  }
}

/// generated route for
/// [SignUpVerifyCodeScreen]
class SignUpVerifyCodeRoute extends PageRouteInfo<SignUpVerifyCodeRouteArgs> {
  SignUpVerifyCodeRoute({
    Key? key,
    required String signUpToken,
    required String phoneNumber,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpVerifyCodeRoute.name,
          args: SignUpVerifyCodeRouteArgs(
            key: key,
            signUpToken: signUpToken,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpVerifyCodeRoute';

  static const PageInfo<SignUpVerifyCodeRouteArgs> page =
      PageInfo<SignUpVerifyCodeRouteArgs>(name);
}

class SignUpVerifyCodeRouteArgs {
  const SignUpVerifyCodeRouteArgs({
    this.key,
    required this.signUpToken,
    required this.phoneNumber,
  });

  final Key? key;

  final String signUpToken;

  final String phoneNumber;

  @override
  String toString() {
    return 'SignUpVerifyCodeRouteArgs{key: $key, signUpToken: $signUpToken, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [SignUpVerifyStudentScreen]
class SignUpVerifyStudentRoute extends PageRouteInfo<void> {
  const SignUpVerifyStudentRoute({List<PageRouteInfo>? children})
      : super(
          SignUpVerifyStudentRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpVerifyStudentRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
