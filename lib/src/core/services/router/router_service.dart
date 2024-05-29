import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/dash_board/presentation/screens/home_screen.dart';
import '../../../features/petition/presentation/screens/coalition_board_screen.dart';
import '../../../features/petition/presentation/screens/notice_board_screen.dart';
import '../../../features/petition/presentation/screens/notice_post_screen.dart';
import '../../../features/petition/presentation/screens/petition_board_screen.dart';
import '../../../features/petition/presentation/screens/coalition_post_screen.dart';
import '../../../features/petition/presentation/screens/petition_write_screen.dart';
import '../../../features/user/presentation/providers/states/login_state.dart';
import '../../../features/user/presentation/screens/login/find_password_screen.dart';
import '../../../features/user/presentation/screens/login/find_studentId_screen.dart';
import '../../../features/user/presentation/screens/login/login_screen.dart';
import '../../../features/user/presentation/screens/profile_screen.dart';
import '../../../features/user/presentation/screens/sign_up/sign_up_agree_policy_screen.dart';
import '../../../features/user/presentation/screens/sign_up/sign_up_complete_screen.dart';
import '../../../features/user/presentation/screens/sign_up/sign_up_screen.dart';
import '../../../features/user/presentation/screens/sign_up/verify_student_screen.dart';
import '../../../features/user/user_dependency_injections.dart';
import '../../../init_dependency_injections.dart';
import 'board_screen.dart';
import '../../../features/petition/presentation/screens/petition_post_screen.dart';
import '../../../features/petition/presentation/screens/post_search_screen.dart';
import '../../../features/timetable/presentation/screens/search_lecture_screen.dart';
import '../../../features/timetable/presentation/screens/add_schedule_screen.dart';
import '../../../features/timetable/presentation/screens/timetable_screen.dart';
import '../../../features/timetable/presentation/screens/schedule_info_screen.dart';

import 'main_screen.dart';
import 'no_internet_screen.dart';
import 'route_error_screen.dart';

part 'app_route.dart';

final routerServiceProvider = Provider<RouterService>(
  (ref) {
    return RouterService(
      redirect: (context, state) async {
        if (!state.uri.path.contains(AppRoute.noInternet.path) &&
            !state.uri.path.contains(AppRoute.login.path)) {
          final storageService = ref.read(storageServiceProvider);

          if (ref.read(loginProvider) is! LoginSuccessState &&
              storageService.read('token') != null) {
            await ref.read(loginProvider.notifier).autoLogin();
            //remove flash screen
            FlutterNativeSplash.remove();
          } else {
            FlutterNativeSplash.remove();
          }

          if (ref.read(loginProvider) is LoginSuccessState) {
            return state.uri.path;
          } else {
            return AppRoute.login.path;
          }
        }
        return null;
      },
    );
  },
);

class RouterService {
  final FutureOr<String?> Function(BuildContext context, GoRouterState state)?
      redirect;

  late final GoRouter _navigator;

  RouteConfiguration get configuration => _navigator.configuration;

  GoRouterDelegate get routerDelegate => _navigator.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      _navigator.routeInformationParser;

  GoRouteInformationProvider get routeInformationProvider =>
      _navigator.routeInformationProvider;

  BackButtonDispatcher get backButtonDispatcher =>
      _navigator.backButtonDispatcher;

  Future<void> pushReplacementNamed(
    String path, {
    bool closeKeyboard = true,
    Map<String, String> queryParameters = const {},
    Map<String, String> pathParameters = const {},
  }) async {
    if (closeKeyboard) {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _navigator.pushReplacementNamed(
      path,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }

  Future<void> pushNamed(
    String path, {
    bool closeKeyboard = true,
    Map<String, String> queryParameters = const {},
    Map<String, String> pathParameters = const {},
  }) async {
    if (closeKeyboard) {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _navigator.pushNamed(
      path,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  Future<void> goNamed(
    String path, {
    bool closeKeyboard = true,
    Map<String, String> queryParameters = const {},
    Map<String, String> pathParameters = const {},
  }) async {
    if (closeKeyboard) {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _navigator.goNamed(
      path,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
    );
  }

  Future<void> pop({
    bool closeKeyboard = true,
  }) async {
    if (closeKeyboard) {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _navigator.pop();
  }

  RouterService({
    this.redirect,
  }) {
    _navigator = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: AppRoute.home.path,
      errorBuilder: (context, state) {
        return const RouteErrorScreen();
      },
      redirect: redirect,
      routes: [
        GoRoute(
          name: AppRoute.noInternet.name,
          path: AppRoute.noInternet.path,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const NoInternetScreen(),
            opaque: false,
            transitionsBuilder: (_, __, ___, child) {
              return child;
            },
          ),
        ),
        GoRoute(
          name: AppRoute.login.name,
          path: AppRoute.login.path,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: AppRoute.findStudentId.name,
          path: AppRoute.findStudentId.path,
          builder: (context, state) => const FindStudentIdScreen(),
        ),
        GoRoute(
          name: AppRoute.findPassword.name,
          path: AppRoute.findPassword.path,
          builder: (context, state) => const FindPasswordScreen(),
        ),
        GoRoute(
          name: AppRoute.verifyStudent.name,
          path: AppRoute.verifyStudent.path,
          builder: (context, state) => VerifyStudentScreen(
            isExpired: bool.parse(state.uri.queryParameters['isExpired']!),
          ),
        ),
        GoRoute(
          name: AppRoute.signUpAgreePolicy.name,
          path: AppRoute.signUpAgreePolicy.path,
          builder: (context, state) => const SignUpAgreePolicyScreen(),
        ),
        GoRoute(
          name: AppRoute.signUp.name,
          path: AppRoute.signUp.path,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: AppRoute.signUpComplete.name,
          path: AppRoute.signUpComplete.path,
          builder: (context, state) => const SignUpCompleteScreen(),
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
                  name: AppRoute.home.name,
                  path: AppRoute.home.path,
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
                          name: AppRoute.noticeBoard.name,
                          path: AppRoute.noticeBoard.path,
                          builder: (context, state) =>
                              const NoticeBoardScreen(),
                        ),
                      ],
                    ),
                    StatefulShellBranch(
                      routes: [
                        GoRoute(
                          name: AppRoute.coalitionBoard.name,
                          path: AppRoute.coalitionBoard.path,
                          builder: (context, state) =>
                              const CoalitionBoardScreen(),
                        ),
                      ],
                    ),
                    StatefulShellBranch(
                      routes: [
                        GoRoute(
                          name: AppRoute.petitionBoard.name,
                          path: AppRoute.petitionBoard.path,
                          builder: (context, state) =>
                              const PetitionBoardScreen(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoute.timetable.name,
                  path: AppRoute.timetable.path,
                  builder: (context, state) => const TimetableScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoute.profile.name,
                  path: AppRoute.profile.path,
                  builder: (context, state) => const ProfileScreen(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          name: AppRoute.noticePost.name,
          path: AppRoute.noticePost.path,
          builder: (context, state) => NoticePostScreen(
            id: int.parse(state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          name: AppRoute.coalitionPost.name,
          path: AppRoute.coalitionPost.path,
          builder: (context, state) => CoalitionPostScreen(
            id: int.parse(state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          name: AppRoute.petitionPost.name,
          path: AppRoute.petitionPost.path,
          builder: (context, state) => PetitionPostScreen(
            id: int.parse(state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          name: AppRoute.petitionWrite.name,
          path: AppRoute.petitionWrite.path,
          builder: (context, state) => const PetitionWriteScreen(),
        ),
        GoRoute(
          name: AppRoute.postSearch.name,
          path: AppRoute.postSearch.path,
          builder: (context, state) => const PostSearchScreen(),
        ),
        GoRoute(
          name: AppRoute.searchLecture.name,
          path: AppRoute.searchLecture.path,
          builder: (context, state) => SearchLectureScreen(
            startHour: int.parse(state.uri.queryParameters['startHour']!),
            endHour: int.parse(state.uri.queryParameters['endHour']!),
          ),
        ),
        GoRoute(
          name: AppRoute.scheduleInfo.name,
          path: AppRoute.scheduleInfo.path,
          builder: (context, state) => ScheduleInfoScreen(
            startHour: int.parse(state.uri.queryParameters['startHour']!),
            endHour: int.parse(state.uri.queryParameters['endHour']!),
            weekdays: int.parse(state.uri.queryParameters['weekdays']!),
            id: int.parse(state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          name: AppRoute.addSchedule.name,
          path: AppRoute.addSchedule.path,
          builder: (context, state) => AddScheduleScreen(
            startHour: int.parse(state.uri.queryParameters['startHour']!),
            endHour: int.parse(state.uri.queryParameters['endHour']!),
            weekdays: int.parse(state.uri.queryParameters['weekdays']!),
          ),
        ),
      ],
    );
  }
}
