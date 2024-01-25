import 'package:danvery/src/features/auth/presentation/presentation.dart';
import 'package:danvery/src/route/app_route.dart';
import 'package:danvery/src/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'route_error_screen.dart';

class RouteObServer extends NavigatorObserver {

  final Ref ref;

  RouteObServer(this.ref);

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    if (kDebugMode) {
      print('Route Observer > didPop : ${route.settings.name}');
    }
    _cancelAllRequest();
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print('Route Observer > didPush : ${route.settings.name}');
    }
    _cancelAllRequest();
    super.didPush(route, previousRoute);
  }

  _cancelAllRequest() {
    final dioClient = ref.read(dioClientProvider);
    dioClient.cancelAllRequests();
  }
}

final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/',
      observers: [
        RouteObServer(ref),
      ],
      routes: [
        GoRoute(
          path: '/',
          name: AppRoute.login.name,
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'loginHelp',
              name: AppRoute.loginHelp.name,
              builder: (context, state) => const LoginHelpScreen(),
            ),
            GoRoute(
              path: 'signUp/verifyStudent',
              name: AppRoute.signUpVerifyStudent.name,
              builder: (context, state) => const VerifyStudentScreen(),
            ),
            GoRoute(
              path: 'signUp/agreePolicy',
              name: AppRoute.signUpAgreePolicy.name,
              builder: (context, state) => const AgreePolicyScreen(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) {
        return RouteErrorScreen(errorMessage: state.error.toString());
      },
    );
  },
);
