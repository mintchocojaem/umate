import 'package:danvery/src/module/orb/test_widget/orb_test_widget.dart';
import 'package:danvery/src/route/app_route.dart';
import 'package:danvery/src/utils/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/sign_up/verify_student/pages/verify_student_screen.dart';
import 'route_error_screen.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: AppRoute.login.name,
          builder: (context, state) => OrbTestWidget(
            onPressLightTheme: () {
              ref
                  .read(themeModeProvider.notifier)
                  .update((state) => ThemeMode.light);
            },
            onPressDarkTheme: () {
              ref
                  .read(themeModeProvider.notifier)
                  .update((state) => ThemeMode.dark);
            },
          ),
          routes: [
            GoRoute(
              path: 'signUp/verifyStudent',
              name: AppRoute.signUpVerifyStudent.name,
              builder: (context, state) => VerifyStudentScreen(),
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
