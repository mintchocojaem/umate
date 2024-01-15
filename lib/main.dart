import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'src/core/core.dart';
import '/src/data/data.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OrbSnackBar.init(navigatorKey: navigatorKey);
  OrbDialog.init(navigatorKey: navigatorKey);
  DioClient.init(
    baseUrl: developmentBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
    onRequest: (requestOptions) async {
      // 요청 전에 처리할 내용 추가
      if (kDebugMode) {
        print("Dio > (Request) ${requestOptions.uri}");
      }
      //Request 딜레이
      await Future.delayed(const Duration(seconds: 2));
    },
    onResponse: (response) async {
      // 응답 전에 처리할 내용 추가
      if (kDebugMode) {
        print("Dio > (Response) ${response.data}");
      }
    },
    onError: (dioException) async {
      // 에러 전에 처리할 내용 추가
      final messages = (dioException.response?.data['message'] as List<dynamic>?);

      if (dioException.type == DioExceptionType.cancel) {
        if (kDebugMode) {
          print("Dio > (Cancel) ${dioException.requestOptions.uri}");
        }
        return;
      }

      final int statusCode = dioException.response?.statusCode ?? 500;
      if (kDebugMode) {
        print(
            "Dio > (Error) code = $statusCode, message = ${messages.toString()}");
      }

      OrbSnackBar.show(
        type: OrbSnackBarType.error,
        message: messages?.first.toString() ?? '알 수 없는 오류가 발생했습니다.',
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
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp(
      navigatorKey: navigatorKey,
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
