import 'package:danvery/domain/find/find_info.dart';
import 'package:danvery/routes/route_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:danvery/domain/domain.dart';
import '../screens/screens.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: RouteInfo.main.path,
      routes: [
        GoRoute(
          path: RouteInfo.login.path,
          builder: (context, state) => LoginScreen(key: state.pageKey),
          routes: [
            GoRoute(
              path: RouteInfo.loginHelp.path,
              builder: (context, state) => LoginHelpScreen(key: state.pageKey),
              routes: [
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
                      VerifySMStoResetPasswordScreen(key: state.pageKey, findInfo: state.extra as FindInfo,),
                ),
                GoRoute(
                  path: RouteInfo.resetPassword.path,
                  builder: (context, state) =>
                      ResetPasswordScreen(key: state.pageKey,findInfo: state.extra as FindInfo),
                ),
                GoRoute(
                  path: RouteInfo.resetPasswordComplete.path,
                  builder: (context, state) =>
                      ResetPasswordCompleteScreen(key: state.pageKey),
                ),
              ],
            ),
            GoRoute(
              path: RouteInfo.signUpVerifyStudent.path,
              builder: (context, state) =>
                  SignUpVerifyStudentScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpAgree.path,
              builder: (context, state) =>
                  SignUpAgreeScreen(key: state.pageKey),
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
              path: RouteInfo.signUpNickname.path,
              builder: (context, state) =>
                  SignUpNicknameScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpPassword.path,
              builder: (context, state) =>
                  SignUpPasswordScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.signUpComplete.path,
              builder: (context, state) =>
                  SignUpCompleteScreen(key: state.pageKey),
            ),
          ],
        ),
        GoRoute(
          path: RouteInfo.main.path,
          builder: (context, state) => MainScreen(key: state.pageKey),
          routes: [
            GoRoute(
              path: RouteInfo.home.path,
              builder: (context, state) => HomeScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteInfo.timetable.path,
              builder: (context, state) => TimetableScreen(key: state.pageKey),
              routes: [
                GoRoute(
                  path: RouteInfo.timetableSearch.path,
                  builder: (context, state) =>
                      TimetableSearchScreen(key: state.pageKey),
                ),
              ],
            ),
            GoRoute(
              path: RouteInfo.board.path,
              builder: (context, state) => BoardScreen(
                key: state.pageKey,
              ),
              routes: [
                GoRoute(
                  path: RouteInfo.petitionDetail.path,
                  builder: (context, state) => PetitionDetailScreen(
                    key: state.pageKey,
                    id: state.extra as int,
                  ),
                ),
                GoRoute(
                  path: RouteInfo.petitionWrite.path,
                  builder: (context, state) => PetitionWriteScreen(
                    key: state.pageKey,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: RouteInfo.profile.path,
              builder: (context, state) => ProfileScreen(key: state.pageKey),
            ),
          ],
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
            !state.fullPath!.contains(RouteInfo.login.path)) {
          //return RouteName.login;
        }
        return null;
      },
    );
  },
);
