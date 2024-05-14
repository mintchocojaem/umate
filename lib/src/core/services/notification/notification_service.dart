import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../firebase_options.dart';

/// 앱이 foreground 상태일 때 안드로이드에선 알림을 수신이 불가능하므로 flutter local notification을 사용
/// 앱이 background 상태일 땐 FCM의 onBackgroundMessage와 onMessage.listen를 통해 알림을 수신
/// 앱이 terminated 상태일 때 알림을 수신할 수 있는건 OS에서 처리하기 때문(파이어베이스 웹에서 작성하는 FCM으론 가능하지만, json으로 직접 쏴줄땐 따로 payload 설정 필요)

class NotificationService {
  final String _vapidKey =
      "BP1Mx7KFHnzqA_OqWv-HSbd5Q8NDeib7non7xXsK3e6VU7ZhxMdl36eKx3glRgA9_mVTrSWGSGdxn9jjYDE2ziE";

  bool isInitialized = false;

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'umate_notification_channel_id', // id
    'Umate', // title
    description: 'umate_notification_channel', // description
    // description
    importance: Importance.high,
  );

  //singleton
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  init() async {
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // iOS foreground notification 권한
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // 토큰 요청
    await getToken();
  }

  Future<void> getToken() async {
    // use the registration token to send messages to users from your trusted server environment
    String? token;

    final messaging = FirebaseMessaging.instance;

    if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
      token = await messaging.getToken(
        vapidKey: _vapidKey,
      );
    } else {
      token = await messaging.getToken();
    }

    if (kDebugMode) {
      print('Firebase Token = $token');
    }
  }

  Future<void> removeToken() async {
    await FirebaseMessaging.instance.deleteToken().whenComplete(() {
      if (kDebugMode) {
        print('FCM token removed');
      }
    });
  }

  ///로컬 알림 보이기
  void showLocalNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      // 웹이 아니면서 안드로이드이고, 알림이 있는경우
      plugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@drawable/ic_notification',
          ),
        ),
      );
    }
  }
}

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
// If you're going to use other Firebase services in the background, such as Firestore,
// make sure you call `initializeApp` before using other Firebase services.
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    NotificationService().showLocalNotification(message);
  }
}

void onMessage(RemoteMessage message) {
  if (kDebugMode) {
    print("Handling a foreground message: ${message.messageId}");
    NotificationService().showLocalNotification(message);
  }
}
