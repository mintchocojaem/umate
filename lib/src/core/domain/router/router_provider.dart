import 'package:danvery/src/core/presentation/presentation.dart';
import 'package:danvery/src/core/data/data.dart';
import 'package:danvery/src/features/auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'app_route.dart';

part 'route_orbserver.dart';

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
