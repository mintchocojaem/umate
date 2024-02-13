
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/features.dart';
import '../../modules/modules.dart';

part 'app_router.gr.dart';

part 'main_screen.dart';

part 'route_error_screen.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: LoginRoute.page,
          //initial: true,
        ),
        AutoRoute(page: LoginHelpRoute.page),
        AutoRoute(page: VerifyStudentRoute.page),
        AutoRoute(page: AgreePolicyRoute.page),
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: PetitionBoardRoute.page),
          ],
        ),
      ];
}
