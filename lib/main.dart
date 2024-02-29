import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/core/config/firebase_config.dart';
import 'src/core/utils/provider_logger.dart';
import 'src/core/services/notification/notification_service.dart';
import 'src/core/services/storage/storage_service.dart';
import 'src/design_system/orb/orb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await StorageService.init(); //setupFlutterNotification 보다 먼저 초기화 되어야 함

  OrbService.init();

  //Notification Setup
  await setupFlutterNotifications();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      child: const App(),
    ),
  );
}
