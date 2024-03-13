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
    AgreePolicyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AgreePolicyScreen(),
      );
    },
    InputUserPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<InputUserPasswordRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InputUserPasswordScreen(
          key: args.key,
          signUpToken: args.signUpToken,
          nickname: args.nickname,
        ),
      );
    },
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
    SendSignUpCodeRoute.name: (routeData) {
      final args = routeData.argsAs<SendSignUpCodeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SendSignUpCodeScreen(
          key: args.key,
          signUpToken: args.signUpToken,
          student: args.student,
        ),
      );
    },
    SignUpCompleteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpCompleteScreen(),
      );
    },
    VerifyNicknameRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyNicknameRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VerifyNicknameScreen(
          key: args.key,
          signUpToken: args.signUpToken,
        ),
      );
    },
    VerifySignUpCodeRoute.name: (routeData) {
      final args = routeData.argsAs<VerifySignUpCodeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VerifySignUpCodeScreen(
          key: args.key,
          signUpToken: args.signUpToken,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    VerifyStudentRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const VerifyStudentScreen(),
      );
    },
  };
}

/// generated route for
/// [AgreePolicyScreen]
class AgreePolicyRoute extends PageRouteInfo<void> {
  const AgreePolicyRoute({List<PageRouteInfo>? children})
      : super(
          AgreePolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'AgreePolicyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InputUserPasswordScreen]
class InputUserPasswordRoute extends PageRouteInfo<InputUserPasswordRouteArgs> {
  InputUserPasswordRoute({
    Key? key,
    required String signUpToken,
    required String nickname,
    List<PageRouteInfo>? children,
  }) : super(
          InputUserPasswordRoute.name,
          args: InputUserPasswordRouteArgs(
            key: key,
            signUpToken: signUpToken,
            nickname: nickname,
          ),
          initialChildren: children,
        );

  static const String name = 'InputUserPasswordRoute';

  static const PageInfo<InputUserPasswordRouteArgs> page =
      PageInfo<InputUserPasswordRouteArgs>(name);
}

class InputUserPasswordRouteArgs {
  const InputUserPasswordRouteArgs({
    this.key,
    required this.signUpToken,
    required this.nickname,
  });

  final Key? key;

  final String signUpToken;

  final String nickname;

  @override
  String toString() {
    return 'InputUserPasswordRouteArgs{key: $key, signUpToken: $signUpToken, nickname: $nickname}';
  }
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
/// [SendSignUpCodeScreen]
class SendSignUpCodeRoute extends PageRouteInfo<SendSignUpCodeRouteArgs> {
  SendSignUpCodeRoute({
    Key? key,
    required String signUpToken,
    required StudentModel student,
    List<PageRouteInfo>? children,
  }) : super(
          SendSignUpCodeRoute.name,
          args: SendSignUpCodeRouteArgs(
            key: key,
            signUpToken: signUpToken,
            student: student,
          ),
          initialChildren: children,
        );

  static const String name = 'SendSignUpCodeRoute';

  static const PageInfo<SendSignUpCodeRouteArgs> page =
      PageInfo<SendSignUpCodeRouteArgs>(name);
}

class SendSignUpCodeRouteArgs {
  const SendSignUpCodeRouteArgs({
    this.key,
    required this.signUpToken,
    required this.student,
  });

  final Key? key;

  final String signUpToken;

  final StudentModel student;

  @override
  String toString() {
    return 'SendSignUpCodeRouteArgs{key: $key, signUpToken: $signUpToken, student: $student}';
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
/// [VerifyNicknameScreen]
class VerifyNicknameRoute extends PageRouteInfo<VerifyNicknameRouteArgs> {
  VerifyNicknameRoute({
    Key? key,
    required String signUpToken,
    List<PageRouteInfo>? children,
  }) : super(
          VerifyNicknameRoute.name,
          args: VerifyNicknameRouteArgs(
            key: key,
            signUpToken: signUpToken,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyNicknameRoute';

  static const PageInfo<VerifyNicknameRouteArgs> page =
      PageInfo<VerifyNicknameRouteArgs>(name);
}

class VerifyNicknameRouteArgs {
  const VerifyNicknameRouteArgs({
    this.key,
    required this.signUpToken,
  });

  final Key? key;

  final String signUpToken;

  @override
  String toString() {
    return 'VerifyNicknameRouteArgs{key: $key, signUpToken: $signUpToken}';
  }
}

/// generated route for
/// [VerifySignUpCodeScreen]
class VerifySignUpCodeRoute extends PageRouteInfo<VerifySignUpCodeRouteArgs> {
  VerifySignUpCodeRoute({
    Key? key,
    required String signUpToken,
    required String phoneNumber,
    List<PageRouteInfo>? children,
  }) : super(
          VerifySignUpCodeRoute.name,
          args: VerifySignUpCodeRouteArgs(
            key: key,
            signUpToken: signUpToken,
            phoneNumber: phoneNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifySignUpCodeRoute';

  static const PageInfo<VerifySignUpCodeRouteArgs> page =
      PageInfo<VerifySignUpCodeRouteArgs>(name);
}

class VerifySignUpCodeRouteArgs {
  const VerifySignUpCodeRouteArgs({
    this.key,
    required this.signUpToken,
    required this.phoneNumber,
  });

  final Key? key;

  final String signUpToken;

  final String phoneNumber;

  @override
  String toString() {
    return 'VerifySignUpCodeRouteArgs{key: $key, signUpToken: $signUpToken, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [VerifyStudentScreen]
class VerifyStudentRoute extends PageRouteInfo<void> {
  const VerifyStudentRoute({List<PageRouteInfo>? children})
      : super(
          VerifyStudentRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyStudentRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
