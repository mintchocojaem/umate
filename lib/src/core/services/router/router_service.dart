import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/board/presentation/screens/coalition_board_screen.dart';
import '../../../features/board/presentation/screens/notice_board_screen.dart';
import '../../../features/board/presentation/screens/petition_board_screen.dart';
import '../../../features/dash_board/presentation/screens/home_screen.dart';
import '../../../features/user/presentation/providers/login_token_provider.dart';
import '../../../features/user/presentation/screens/login_screen.dart';
import '../../../features/board/presentation/screens/board_screen.dart';

import '../../../features/user/presentation/screens/sign_up_agree_policy_screen.dart';
import '../../../features/user/presentation/screens/sign_up_complete_screen.dart';
import '../../../features/user/presentation/screens/sign_up_screen.dart';
import '../../../features/user/presentation/screens/sign_up_verify_student_screen.dart';
import 'main_screen.dart';
import 'route_error_screen.dart';

enum AppRoute {
  noInternet,
  login,
  findStudentId,
  findPassword,
  signUpVerifyStudent,
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
    final loginNotifier = ValueNotifier(ref.read(loginTokenProvider).value);
    ref.listen(
      loginTokenProvider,
      (_, next) {
        loginNotifier.value = next.value;
      },
    );
    ref.onDispose(() {
      loginNotifier.dispose();
    });
    return RouterService(
      navigator: GoRouter(
        initialLocation: '/home',
        debugLogDiagnostics: true,
        refreshListenable: loginNotifier,
        redirect: (context, state) async {
          final loginToken = ref.read(loginTokenProvider).value;
          if (loginToken == null &&
              !(state.uri.path.contains('login') ||
                  state.uri.path.contains('sign_up'))) {
            return '/login';
          }
          return null;
        },
        errorBuilder: (context, state) {
          return const RouteErrorScreen();
        },
        routes: [
          GoRoute(
            path: '/login',
            name: AppRoute.login.name,
            builder: (context, state) {
              return const LoginScreen();
            },
          ),
          GoRoute(
            path: '/sign_up',
            name: AppRoute.signUp.name,
            builder: (context, state) {
              return const SignUpScreen();
            },
            routes: [
              GoRoute(
                path: 'verify_student',
                name: AppRoute.signUpVerifyStudent.name,
                builder: (context, state) {
                  return const SignUpVerifyStudentScreen();
                },
              ),
              GoRoute(
                path: 'agree_policy',
                name: AppRoute.signUpAgreePolicy.name,
                builder: (context, state) {
                  return const SignUpAgreePolicyScreen();
                },
              ),
              GoRoute(
                path: 'complete',
                name: AppRoute.signUpComplete.name,
                builder: (context, state) {
                  return SignUpCompleteScreen(
                    userPassword: state.extra as String,
                  );
                },
              ),
            ],
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
                  GoRoute(
                    path: '/home',
                    name: AppRoute.home.name,
                    builder: (context, state) => const HomeScreen(),
                  ),
                ],
              ),
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
                            path: '/board/notice',
                            name: AppRoute.noticeBoard.name,
                            builder: (context, state) =>
                                const NoticeBoardScreen(),
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        routes: [
                          GoRoute(
                            path: '/board/coalition',
                            name: AppRoute.coalitionBoard.name,
                            builder: (context, state) =>
                                const CoalitionBoardScreen(),
                          ),
                        ],
                      ),
                      StatefulShellBranch(
                        routes: [
                          GoRoute(
                            path: '/board/petition',
                            name: AppRoute.petitionBoard.name,
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
      ),
    );
  },
);

class RouterService {
  final GoRouter navigator;

  RouterService({
    required this.navigator,
  });

  Future<Object?> pushNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) async {
    await _hideKeyboard();
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
    await _hideKeyboard();
    return await navigator.pushReplacementNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  Future<void> goNamed(
    String name, {
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    Object? extra,
  }) async {
    await _hideKeyboard();
    return navigator.goNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  Future<void> pop<T extends Object?>([T? result]) async {
    await _hideKeyboard();
    return navigator.pop(result);
  }

  Future<void> _hideKeyboard() async {
    final context = navigator.routerDelegate.navigatorKey.currentContext;
    if (context == null) return;

    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    if (keyboardVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 200), () {});
    }
  }
}
