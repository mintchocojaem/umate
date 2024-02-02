import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/features.dart';
import '../../modules/modules.dart';
import '../configs.dart';
import 'route_error_screen.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/',
      observers: [
        RouteObServer(ref),
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
      routes: [
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
        StatefulShellRoute.indexedStack(
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/',
                  name: AppRoute.home.name,
                  builder: (context, state) {
                    return Container(
                      color: Colors.green,
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/board',
                  name: AppRoute.board.name,
                  builder: (context, state) => const PetitionBoardScreen(),
                ),
              ],
            ),
          ],
          builder: (context, state, shell) {
            return Scaffold(
              body: SafeArea(
                child: shell,
              ),
              bottomNavigationBar: OrbBottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.assignment), label: "게시판"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.space_dashboard), label: "시간표"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "내 정보"),
                ],
                currentIndex: shell.currentIndex,
                onIndexChanged: (index) {
                  shell.goBranch(index);
                },
              ),
            );
          },
        ),
      ],
    );
  },
);
