import 'package:danvery/routes/route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/auth/auth.dart';
import '../screens/screens.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: RouteName.main,
      routes: [
        GoRoute(
          path: RouteName.main,
          builder: (context, state) => MainScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.home,
          builder: (context, state) => HomeScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.timetable,
          builder: (context, state) => TimetableScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.board,
          builder: (context, state) => BoardScreen(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: RouteName.petitionPost,
          builder: (context, state) => PetitionPostScreen(
            key: state.pageKey,
            postId: state.extra as int,
          ),
        ),
        GoRoute(
          path: RouteName.profile,
          builder: (context, state) => ProfileScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.login,
          builder: (context, state) => LoginScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.loginHelp,
          builder: (context, state) => LoginHelpScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.signUpVerifyStudent,
          builder: (context, state) =>
              SignUpVerifyStudentScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.signUpAgree,
          builder: (context, state) => SignUpAgreeScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.signUpCheckInfo,
          builder: (context, state) =>
              SignUpCheckInfoScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.signUpVerifySMS,
          builder: (context, state) =>
              SignUpVerifySmsScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.signUpNickName,
          builder: (context, state) => SignUpNicknameScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.signUpPassword,
          builder: (context, state) => SignUpPasswordScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.signUpComplete,
          builder: (context, state) => SignUpCompleteScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.findUserId,
          builder: (context, state) => FindUserIdScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.findUserIdComplete,
          builder: (context, state) =>
              FindUserIdCompleteScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.sendSMStoResetPassword,
          builder: (context, state) =>
              SendSMStoResetPasswordScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.verifySMStoResetPassword,
          builder: (context, state) =>
              VerifySMStoResetPasswordScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.resetPassword,
          builder: (context, state) => ResetPasswordScreen(key: state.pageKey),
        ),
        GoRoute(
          path: RouteName.resetPasswordComplete,
          builder: (context, state) =>
              ResetPasswordCompleteScreen(key: state.pageKey),
        ),
      ],
      errorBuilder: (context, state) => RouteErrorScreen(
        key: state.pageKey,
        errorMessage: state.error.toString(),
      ),
      redirect: (context, state) {
        if (state.fullPath == null || state.fullPath!.isEmpty) {
          //page not found error
        } else if (ref.watch(tokenProvider).value == null &&
            !state.fullPath!.contains(RouteName.login)) {
          //return RouteName.login;
        }
        return null;
      },
    );
  },
);
