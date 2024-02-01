import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/features.dart';
import '../configs.dart';
import 'main_screen.dart';
import 'route_error_screen.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/',
      observers: [
        RouteObServer(ref),
      ],
      routes: [
        GoRoute(
          path: '/',
          name: AppRoute.main.name,
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: '/login',
          name: AppRoute.login.name,
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'help',
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
      redirect: (context, state) {
        final token = ref.read(tokenProvider);
        if (!(token.hasValue || state.fullPath!.contains('/login'))) {
          //return '/login';
        }
        return null;
      },
    );
  },
);
