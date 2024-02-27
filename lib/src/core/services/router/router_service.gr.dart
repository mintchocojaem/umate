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
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [PetitionBoardScreen]
class PetitionBoardRoute extends PageRouteInfo<void> {
  const PetitionBoardRoute({List<PageRouteInfo>? children})
      : super(
          PetitionBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'PetitionBoardRoute';

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
