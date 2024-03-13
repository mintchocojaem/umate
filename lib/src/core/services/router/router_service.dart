import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/auth/domain/models/student_model.dart';
import '../../../features/auth/presentation/login/screens/login_help_screen.dart';
import '../../../features/auth/presentation/login/screens/login_screen.dart';
import '../../../features/auth/presentation/sign_up/screens/agree_policy_screen.dart';
import '../../../features/auth/presentation/sign_up/screens/input_user_password_screen.dart';
import '../../../features/auth/presentation/sign_up/screens/send_sign_up_code_screen.dart';
import '../../../features/auth/presentation/sign_up/screens/sign_up_complete_screen.dart';
import '../../../features/auth/presentation/sign_up/screens/verify_nickname_screen.dart';
import '../../../features/auth/presentation/sign_up/screens/verify_sign_up_code_screen.dart';
import '../../../features/auth/presentation/sign_up/screens/verify_student_screen.dart';

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
        AutoRoute(page: VerifyStudentRoute.page),
        AutoRoute(page: AgreePolicyRoute.page),
        AutoRoute(page: SendSignUpCodeRoute.page),
        AutoRoute(page: VerifySignUpCodeRoute.page),
        AutoRoute(page: VerifyNicknameRoute.page),
        AutoRoute(page: InputUserPasswordRoute.page),
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
