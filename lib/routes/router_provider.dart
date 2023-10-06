import 'package:danvery/routes/route_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/auth/auth.dart';
import '../screens/screens.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: RouteInfo.login.fullPath,
      routes: [
        GoRoute(
          path: RouteInfo.main.fullPath,
          builder: (context, state) => MainScreen(key: state.pageKey),
          routes: [
            GoRoute(
              path: RouteInfo.home.path,
              builder: (context, state) => HomeScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.timetable.path,
              builder: (context, state) => TimetableScreen(key: state.pageKey),
            ),
            GoRoute(
                path: RouteInfo.board.path,
                builder: (context, state) => BoardScreen(
                      key: state.pageKey,
                    ),
                routes: [
                  GoRoute(
                    path: RouteInfo.petition.path,
                    builder: (context, state) => PetitionPostScreen(
                      key: state.pageKey,
                      postId: state.extra as int,
                    ),
                  ),
                ]),
            GoRoute(
              path: RouteInfo.profile.path,
              builder: (context, state) => ProfileScreen(key: state.pageKey),
            ),
          ],
        ),
        GoRoute(
          path: RouteInfo.login.fullPath,
          builder: (context, state) => LoginScreen(key: state.pageKey),
          routes: [
            GoRoute(
              path: RouteInfo.loginHelp.path,
              builder: (context, state) => LoginHelpScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpVerifyStudent.path,
              builder: (context, state) =>
                  SignUpVerifyStudentScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpAgree.path,
              builder: (context, state) => SignUpAgreeScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpCheckInfo.path,
              builder: (context, state) =>
                  SignUpCheckInfoScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpVerifySMS.path,
              builder: (context, state) =>
                  SignUpVerifySmsScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpNickName.path,
              builder: (context, state) => SignUpNicknameScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpPassword.path,
              builder: (context, state) => SignUpPasswordScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpComplete.path,
              builder: (context, state) => SignUpCompleteScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.findUserId.path,
              builder: (context, state) => FindUserIdScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.findUserIdComplete.path,
              builder: (context, state) =>
                  FindUserIdCompleteScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.sendSMStoResetPassword.path,
              builder: (context, state) =>
                  SendSMStoResetPasswordScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.verifySMStoResetPassword.path,
              builder: (context, state) =>
                  VerifySMStoResetPasswordScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.resetPassword.path,
              builder: (context, state) => ResetPasswordScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.resetPasswordComplete.path,
              builder: (context, state) =>
                  ResetPasswordCompleteScreen(key: state.pageKey),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => RouteErrorScreen(
        key: state.pageKey,
        errorMessage: state.error.toString(),
      ),
      redirect: (context, state) {
        print(state.fullPath);
        if (state.fullPath == null || state.fullPath!.isEmpty) {
          //page not found error
        } else if (ref.watch(tokenProvider).value == null &&
            !state.fullPath!.contains(RouteInfo.login.fullPath)) {
          //return RouteName.login;
        }
        return null;
      },
    );
  },
);
