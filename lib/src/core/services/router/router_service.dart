import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/auth/domain/models/student_model.dart';
import '../../../features/auth/presentation/screens/login_help_screen.dart';
import '../../../features/auth/presentation/screens/login_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_password_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_policy_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_send_code_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_complete_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_nickname_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_verify_code_screen.dart';
import '../../../features/auth/presentation/screens/sign_up_verify_student_screen.dart';

import 'main_screen.dart';
import 'no_internet_screen.dart';
import 'route_error_screen.dart';

part 'router_service.gr.dart';

final routerServiceProvider = Provider<RouterService>(
  (ref) {
    return RouterService();
  },
);

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class RouterService extends _$RouterService {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: LoginRoute.page,
          initial: true,
        ),
        CustomRoute(
          page: NoInternetRoute.page,
          opaque: false,
          fullscreenDialog: true,
        ),
        AutoRoute(page: LoginHelpRoute.page),
        AutoRoute(page: SignUpVerifyStudentRoute.page),
        AutoRoute(page: SignUpPolicyRoute.page),
        AutoRoute(page: SignUpSendCodeRoute.page),
        AutoRoute(page: SignUpVerifyCodeRoute.page),
        AutoRoute(page: SignUpNicknameRoute.page),
        AutoRoute(page: SignUpPasswordRoute.page),
        AutoRoute(page: SignUpCompleteRoute.page),
        AutoRoute(
          page: MainRoute.page,
          //initial: true,
          children: [
            //AutoRoute(page: HomeRoute.page),
            //AutoRoute(page: PetitionBoardRoute.page),
          ],
        ),
      ];
}
