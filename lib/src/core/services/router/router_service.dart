import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/board/presentation/screen/petition_board_screen.dart';
import '../../../features/user/presentation/screen/login_screen.dart';
import 'board_screen.dart';

import 'main_screen.dart';
import 'no_internet_screen.dart';
import 'route_error_screen.dart';

enum AppRoute {
  noInternet,
  login,
  findStudentId,
  findPassword,
  verifyStudent,
  signUpAgreePolicy,
  signUp,
  signUpComplete,
  home,
  noticeBoard,
  coalitionBoard,
  petitionBoard,
  timetable,
  profile,
  noticePost,
  coalitionPost,
  petitionPost,
  petitionWrite,
  searchPost,
  searchLecture,
  scheduleInfo,
  addSchedule,
}

final routerServiceProvider = Provider<RouterService>(
  (ref) {
    return RouterService(
      redirect: (context, state) async {
        return null;
      },
    );
  },
);

class RouterService {
  final FutureOr<String?> Function(BuildContext context, GoRouterState state)?
      redirect;

  RouterService({
    this.redirect,
  });

  Future<Object?> pushNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) async {
    return await navigator.pushNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  Future<Object?> pushReplacementNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) async {
    return await navigator.pushReplacementNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  void goNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) {
    return navigator.goNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  void pop(dynamic result) {
    return navigator.pop(result);
  }

  final GoRouter navigator = GoRouter(
    initialLocation: '/board/petition',
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      return null;
    },
    errorBuilder: (context, state) {
      return const RouteErrorScreen();
    },
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const LoginScreen(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              StatefulShellRoute.indexedStack(
                builder: (context, state, navigationShell) {
                  return BoardScreen(
                    navigationShell: navigationShell,
                  );
                },
                branches: [
                  StatefulShellBranch(
                    routes: [
                      GoRoute(
                        name: AppRoute.petitionBoard.name,
                        path: '/board/petition',
                        builder: (context, state) =>
                        const PetitionBoardScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
