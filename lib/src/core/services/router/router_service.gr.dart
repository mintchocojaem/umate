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
      final args = routeData.argsAs<RouteErrorRouteArgs>(
          orElse: () => const RouteErrorRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RouteErrorScreen(
          errorMessage: args.errorMessage,
          reasonMessage: args.reasonMessage,
        ),
      );
    },
    SignUpAgreePolicyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpAgreePolicyScreen(),
      );
    },
    SignUpCompleteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpCompleteScreen(),
      );
    },
    SignUpNicknameRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpNicknameScreen(),
      );
    },
    SignUpPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPasswordScreen(),
      );
    },
    SignUpSendCodeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpSendCodeScreen(),
      );
    },
    SignUpVerifyCodeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpVerifyCodeScreen(),
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
    String errorMessage = 'Access Denied',
    String reasonMessage = 'You are not authorized to access this page',
    List<PageRouteInfo>? children,
  }) : super(
          RouteErrorRoute.name,
          args: RouteErrorRouteArgs(
            errorMessage: errorMessage,
            reasonMessage: reasonMessage,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteErrorRoute';

  static const PageInfo<RouteErrorRouteArgs> page =
      PageInfo<RouteErrorRouteArgs>(name);
}

class RouteErrorRouteArgs {
  const RouteErrorRouteArgs({
    this.errorMessage = 'Access Denied',
    this.reasonMessage = 'You are not authorized to access this page',
  });


  final String errorMessage;

  final String reasonMessage;

  @override
  String toString() {
    return 'RouteErrorRouteArgs{errorMessage: $errorMessage, reasonMessage: $reasonMessage}';
  }
}

/// generated route for
/// [SignUpAgreePolicyScreen]
class SignUpAgreePolicyRoute extends PageRouteInfo<void> {
  const SignUpAgreePolicyRoute({List<PageRouteInfo>? children})
      : super(
          SignUpAgreePolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpAgreePolicyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
class SignUpNicknameRoute extends PageRouteInfo<void> {
  const SignUpNicknameRoute({List<PageRouteInfo>? children})
      : super(
          SignUpNicknameRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpNicknameRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPasswordScreen]
class SignUpPasswordRoute extends PageRouteInfo<void> {
  const SignUpPasswordRoute({List<PageRouteInfo>? children})
      : super(
          SignUpPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpSendCodeScreen]
class SignUpSendCodeRoute extends PageRouteInfo<void> {
  const SignUpSendCodeRoute({List<PageRouteInfo>? children})
      : super(
          SignUpSendCodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpSendCodeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpVerifyCodeScreen]
class SignUpVerifyCodeRoute extends PageRouteInfo<void> {
  const SignUpVerifyCodeRoute({List<PageRouteInfo>? children})
      : super(
          SignUpVerifyCodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpVerifyCodeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
