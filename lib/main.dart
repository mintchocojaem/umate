import 'package:danvery/screens/main/profile/profile_screen.dart';
import 'package:danvery/utils/exception_handler.dart';
import 'package:danvery/utils/notification.dart';
import 'package:danvery/utils/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'modules/orb/components/components.dart';
import 'modules/orb/theme/orb_theme.dart';
import 'routes/router_provider.dart';

//should be in MaterialApp and apply this key
final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  ExceptionHandler(
    key: globalNavigatorKey,
    onException: (String message) {
      OrbSnackBar.show(
        context: globalNavigatorKey.currentContext!,
        message: message,
        type: OrbSnackBarType.error,
      );
    },
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SharedPreference.init(); //setupFlutterNotification 보다 먼저 초기화 되어야 함

  // notification setup
  await setupFlutterNotifications();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp(
      navigatorKey: globalNavigatorKey,
      title: 'Danvery',
      theme: ref.watch(themeProvider),
      debugShowCheckedModeBanner: false,
      home: Router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}
