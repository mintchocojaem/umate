import 'package:danvery/domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(key: state.pageKey),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginScreen(key: state.pageKey),
        ),
      ],
      errorBuilder: (context, state) => RouteErrorScreen(
        key: state.pageKey,
        errorMessage: state.error.toString(),
      ),
      redirect: (context, state){
        if(ref.watch(tokenProvider).value == null){
          return '/login';
        } else {
          return null;
        }
      }
    );
  },
);
