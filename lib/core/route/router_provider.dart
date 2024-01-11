import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/presentation.dart';
import 'route_path.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: RouteInfo.login.path,
      routes: [
        GoRoute(
          path: RouteInfo.login.path,
          builder: (context, state) {
            return LoginScreen(key: state.pageKey);
          },
          routes: [
            GoRoute(
              path: RouteInfo.loginHelp.path,
              builder: (context, state) {
                return LoginHelpScreen(key: state.pageKey);
              },
            ),
            GoRoute(
              path: RouteInfo.signUpVerifyStudent.path,
              builder: (context, state) {
                return SignUpVerifyStudentScreen(key: state.pageKey);
              },
            ),
            GoRoute(
              path: RouteInfo.signUpAgreement.path,
              builder: (context, state) {
                return SignUpAgreementScreen(key: state.pageKey);
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) {
        return ErrorScreen(
          errorMessage: state.error.toString(),
        );
      },
    );
  },
);
