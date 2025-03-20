import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Top level background notification handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // dPrint(message.toMap().toString());
  notificationService.showLocalNotification(message);
}

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String fcmToken = '';

  NotificationService() {
    // Initialize Firebase Messaging
    _initializeFCM();
    // Initialize Flutter Local Notifications
    _initializeFlutterLocalNotifications();
  }

  void _initializeFCM() async {
    _firebaseMessaging.setAutoInitEnabled(true);

    // Request permission
    _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
    fcmToken = await _firebaseMessaging.getToken() ?? '';
    // debugPrint('FCM Token: $fcmToken');

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        showLocalNotification(message);
      }
    });
  }

  void handlePendingNotifications() {
    // Handle initial notification when the app is started from a terminated state
    _firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationTap(message);
      }
    });
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Add your notification tap handling logic
  }

  void _initializeFlutterLocalNotifications() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(
            {'data': jsonDecode(details.payload ?? '{}')});
        _handleNotificationTap(message);
      },
    );

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void showLocalNotification(RemoteMessage message) {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.max,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // Define the ID of the notification
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    _flutterLocalNotificationsPlugin.show(
      id,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );

    print(message.toMap().toString());
  }
}

NotificationService notificationService = NotificationService();
